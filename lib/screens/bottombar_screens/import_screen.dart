import 'package:InventorPlus/consts/firebase_consts.dart';
import 'package:InventorPlus/provider/dark_theme_provider.dart';
import 'package:InventorPlus/services/global_metthods.dart';
import 'package:InventorPlus/ui/loading_manager.dart';
import 'package:InventorPlus/ui/widgets/animated_dialog_widget.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({Key? key});

  @override
  _ImportScreenState createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  String searchQuery = '';
  bool _isLoading = false;
  bool _isDeleting = false;
  DocumentSnapshot? _selectedInvoice;

  void _showInvoiceDetailsDialog(
      BuildContext context, DocumentSnapshot invoice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoadingManager(
          isLoading: _isLoading,
          child: AnimatedDialog(
            dialog: Container(
              width: double.infinity,
              height: double.infinity,
              child: AlertDialog(
                title: Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.amber.shade700,
                        width: 1.7,
                      ),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.content_paste_outlined,
                        size: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Thông tin hóa đơn",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                    ],
                  ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                        text: "Ngày tạo: ${invoice['joinedAt']}",
                        textSize: 16,
                        color: null),
                    const SizedBox(height: 15),
                    TextWidget(
                        text: "+ Mã đơn hàng: \n${invoice['code_invoice']}",
                        textSize: 16,
                        color: null),
                    const SizedBox(height: 10),
                    TextWidget(
                        text: "+ Tên đơn hàng: \n${invoice['name_invoice']}",
                        textSize: 16,
                        color: null),
                    const SizedBox(height: 10),
                    TextWidget(
                        text:
                            "+ Địa chỉ đơn hàng: \n${invoice['address_invoice']}",
                        textSize: 16,
                        color: null),
                    const SizedBox(height: 10),
                    TextWidget(
                        text: "+ SĐT: \n${invoice['phone_invoice']}",
                        textSize: 16,
                        color: null),
                    const SizedBox(height: 10),
                    TextWidget(
                        text: "+ Khối lượng: \n${invoice['mass_invoice']}Gram",
                        textSize: 16,
                        color: null),
                    const SizedBox(height: 10),
                    TextWidget(
                        text:
                            "+ Kích thước (Dài x Rộng x Cao): \n${invoice['length_invoice']}Cm X ${invoice['width_invoice']}Cm X ${invoice['height_invoice']}Cm",
                        textSize: 16,
                        color: null),
                    const SizedBox(height: 10),
                    TextWidget(
                        text: "+ Ghi chú: \n${invoice['note_invoice']}",
                        textSize: 16,
                        color: null),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(40, 40)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.amber.shade700),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              onPressed: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                              },
                              child: TextWidget(
                                text: "Đóng",
                                textSize: 18,
                                color: null,
                                textWeight: FontWeight.w600,
                              )),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(40, 40)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.amber.shade700),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              onPressed: () {
                                GlobalMethods.warningDialog(
                                  title: "Xóa đơn hàng",
                                  subtitle:
                                      "Bạn có chắc muốn xóa đơn hàng khỏi hệ thống?",
                                  icon: const Icon(Icons.warning_amber_rounded),
                                  fct: () {
                                    /* Navigator.pop(context);
                                    Navigator.pop(context); */
                                    _deleteInvoice(_selectedInvoice!);
                                  },
                                  context: context,
                                );
                              },
                              child: TextWidget(
                                text: "Xóa",
                                textSize: 18,
                                color: null,
                                textWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteInvoice(DocumentSnapshot invoice) async {
    setState(() {
      _isDeleting = true;
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('invoices')
          .doc(invoice.id)
          .delete()
          .then((value) {
        Fluttertoast.showToast(
          msg: "Xóa hóa đơn thành công",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade600,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        if (_isDeleting) {
          Navigator.pop(context); // Close the dialog
        }
        if (_isDeleting) {
          Navigator.pop(context); // Close the dialog
        }
      });
    } catch (error) {
      // Handle error if needed
    } finally {
      setState(() {
        _isDeleting = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    final User? user = FirebaseAuth.instance.currentUser;
    final _uid = user!.uid;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
                child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.download, color: Colors.amber.shade700),
                    labelText: "Nhập kho đơn hàng",
                    labelStyle: TextStyle(
                      color: Colors.amber.shade700,
                      fontSize: 18,
                    ),
                    hintText: "Nhập mã hóa đơn để nhập kho đơn hàng",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                         width: 2.0,
                          color: _isDark ? Colors.white : Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.amber.shade700),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(14, 243, 215, 132),
                    border: Border.all(
                      color: Colors.amber.shade700,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                          bottom: 5,
                          top: 2,
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          style: const TextStyle(fontSize: 17),
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber.shade700),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelText: 'Tìm kiếm',
                            labelStyle: TextStyle(color: Colors.amber.shade700),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.amber.shade700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Scrollbar(
                        radius: const Radius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: double.maxFinite,
                          height: 452,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('invoices')
                                .where('userId', isEqualTo: _uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Đã xảy ra lỗi: ${snapshot.error}');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.amber.shade700,
                                  ),
                                );
                              }

                              final invoices = snapshot.data!.docs;

                              final filteredInvoices =
                                  invoices.where((invoice) {
                                final invoiceCode =
                                    invoice['code_invoice'] ?? '';
                                final invoiceName =
                                    invoice['name_invoice'] ?? '';

                                return invoiceCode.contains(searchQuery) ||
                                    invoiceName.contains(searchQuery);
                              }).toList();

                              final hasMatchingInvoices =
                                  filteredInvoices.isNotEmpty;

                              return hasMatchingInvoices
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: filteredInvoices.length,
                                      separatorBuilder: (context, index) =>
                                          Divider(),
                                      itemBuilder: (context, index) {
                                        final invoice = filteredInvoices[index];

                                        final invoiceCode =
                                            invoice['code_invoice'] ?? '';
                                        final invoiceName =
                                            invoice['name_invoice'] ?? '';

                                        return ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                              _isDark
                                                  ? Colors.amber.shade600
                                                  : Colors.amber.shade100,
                                            ),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _selectedInvoice = invoice;
                                            });
                                            _showInvoiceDetailsDialog(
                                                context, invoice);
                                          },
                                          child: ListTile(
                                            trailing: const Icon(
                                                IconlyBroken.arrowRight2),
                                            title: Row(
                                              children: [
                                                Icon(
                                                  Icons.event_note,
                                                  size: 32,
                                                  color: Colors.amber.shade700,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      " $invoiceName",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            subtitle: Text(
                                              'Mã HD: $invoiceCode \n${invoice['joinedAt']} ',
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: Text('Không tìm thấy hóa đơn'),
                                    );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
