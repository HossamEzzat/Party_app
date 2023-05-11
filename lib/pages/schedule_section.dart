import 'package:flutter/material.dart';
import 'package:wedding/main.dart';

class schedule_section extends StatefulWidget {
  const schedule_section({Key? key});

  @override
  State<schedule_section> createState() => _schedule_sectionState();
}

class _schedule_sectionState extends State<schedule_section> {
  bool _fire_works = false;
  bool _photography = false;
  bool _bride_maids = false;
  bool _night_party = false;

  int _fire_works_p = 250;
  int _photography_p = 800;
  int _bride_maids_p = 100;
  int _night_party_p = 1500;
  int _totalCount = 0;

  void _updateTotalCount() {
    _totalCount = 0;
    if (_fire_works) {
      _totalCount += _fire_works_p;
    }
    if (_photography) {
      _totalCount += _photography_p;
    }
    if (_bride_maids) {
      _totalCount += _bride_maids_p;
    }
    if (_night_party) {
      _totalCount += _night_party_p;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pinkColor,
        elevation: 0.1,
        title: Text("الجدولة"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: "اكتب التاريخ المحدد",
                      prefixText: "dd/mm/yyyy",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "بتخطط لأيه في فرحك؟",
                      )),
                  CheckboxListTile(
                      title: const Text("تأثيرات والعاب نارية"),
                      activeColor: const Color.fromARGB(153, 245, 13, 121),
                      secondary: Text(_fire_works_p.toString()),
                      value: _fire_works,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? value) {
                        setState(() {
                          _fire_works = value ?? false;
                          _updateTotalCount();
                        });
                      }),
                  CheckboxListTile(
                      title: const Text("ألبوم صور فوتوجرافيا"),
                      activeColor: const Color.fromARGB(153, 245, 13, 121),
                      secondary: Text(_photography_p.toString()),
                      value: _photography,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? value) {
                        setState(() {
                          _photography = value ?? false;
                          _updateTotalCount();
                        });
                      }),
                  CheckboxListTile(
                      title: const Text(" وصيفات الشرف ورفقاء العريس "),
                      activeColor: const Color.fromARGB(153, 245, 13, 121),
                      secondary: Text(_bride_maids_p.toString()),
                      value: _bride_maids,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? value) {
                        setState(() {
                          _bride_maids = value ?? false;
                          _updateTotalCount();
                        });
                      }),
                  CheckboxListTile(
                      title: const Text("حفلة ليلية"),
                      activeColor: const Color.fromARGB(153, 245, 13, 121),
                      secondary: Text(_night_party_p.toString()),
                      value: _night_party,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? value) {
                        setState(() {
                          _night_party = value ?? false;
                          _updateTotalCount();
                        });
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Text(
                        "اجمالي الحساب",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Expanded(
                          child: Text(
                        _totalCount.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ))
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              customButton(text: "حفظ", onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
