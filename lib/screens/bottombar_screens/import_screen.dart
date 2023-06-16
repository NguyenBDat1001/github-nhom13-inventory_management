import 'package:InventorPlus/consts/firebase_consts.dart';
import 'package:InventorPlus/provider/dark_theme_provider.dart';
import 'package:InventorPlus/ui/loading_manager.dart';
import 'package:InventorPlus/ui/widgets/animated_dialog_widget.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({Key? key});

  @override
  _ImportScreenState createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  String searchQuery = '';
  bool _isLoading = false;
  DocumentSnapshot? _selectedInvoice;
 

  void _showInvoiceDetailsDialog(DocumentSnapshot invoice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnimatedDialog(
          dialog: AlertDialog(
            title: Container(padding: const EdgeInsets.only(bottom: 8),
            decoration:  BoxDecoration(
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
                  Icons.assignment_ind_outlined,
                  size: 30,
                ), 
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Thông tin hóa đơn",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ],
            ),
          ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: "Ngày tạo: ${invoice['joinedAt']}", textSize: 16, color: null),
              
                Text('+ Mã HD: ${invoice['code_invoice']}'),
                Text(
                  'Kích thước: ${invoice['length_invoice']}x${invoice['width_invoice']}x${invoice['height_invoice']}',
                ),
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
                            minimumSize:
                                MaterialStateProperty.all(const Size(40, 40)),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.amber.shade700),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)))),
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                        child: TextWidget(text: "Đóng", textSize: 18, color: null,textWeight: FontWeight.w600,)),
                   ),
                
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(40, 40)),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.amber.shade700),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)))),
                        onPressed: () async {
                         
                        },
                        child: TextWidget(text: "Có", textSize: 18, color: null,textWeight: FontWeight.w600,)),
                  ),
                ],
              ),
            ),
            ],
          ),
        );
      },
    );
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
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Tìm kiếm',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: const Color.fromARGB(14, 255, 193, 7),
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
                                                  ? Colors.amber.shade500
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
                                            _showInvoiceDetailsDialog(invoice);
                                          },
                                          child: ListTile(
                                            title: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  invoiceName,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            subtitle: Text(
                                              'Mã HD: $invoiceCode \nKích thước: ',
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
