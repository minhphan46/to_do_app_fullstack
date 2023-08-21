import 'package:flutter/material.dart';

class MyDiaLog extends StatefulWidget {
  final String title;
  final TextEditingController textControler;
  final Function onSave;
  const MyDiaLog({
    super.key,
    required this.textControler,
    required this.onSave,
    required this.title,
  });

  @override
  State<MyDiaLog> createState() => _MyDiaLogState();
}

class _MyDiaLogState extends State<MyDiaLog> {
  bool isNull = true;
  String oldTitle = "";

  bool checkIsOld() {
    return oldTitle == widget.textControler.text;
  }

  @override
  void initState() {
    super.initState();
    oldTitle = widget.textControler.text;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: SizedBox(
        height: 180,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(widget.title),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: widget.textControler,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: "Add a new task",
              ),
              onChanged: (value) {
                setState(() {
                  isNull = value.trim() == "" || checkIsOld();
                });
              },
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent, // mau chu
                    ),
                    child: const Text("Cacel"),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: isNull
                        ? null
                        : () {
                            widget.onSave();
                            Navigator.of(context).pop();
                          },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // mau chu
                    ),
                    child: const Text("Add"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
