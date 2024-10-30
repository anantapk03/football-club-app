import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'profile_controller.dart';

class LanguageSettingPopup extends StatefulWidget {
  final ProfileController? controller;
  const LanguageSettingPopup({super.key, this.controller});

  @override
  State<LanguageSettingPopup> createState() => _LanguageSettingPopupState();
}

class _LanguageSettingPopupState extends State<LanguageSettingPopup> {
  late ProfileController? _controller;

  @override
  void initState() {
    _controller = widget.controller;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      margin: MediaQuery.of(context).viewInsets,
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    height: 10,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0)),
                        color: Colors.grey,
                        border: Border.all(color: Colors.grey)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context)?.language ?? "Language",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _customRadioButton(
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: AppLocalizations.of(context)?.indonesia ??
                              "Indonesia",
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black)),
                      TextSpan(
                          text:
                              ' (${AppLocalizations.of(context)?.defaultLang ?? "Default"})',
                          style: const TextStyle(
                            color: Colors.grey,
                          ))
                    ])),
                    value: 1,
                    groupValue: _controller?.isLang.value ?? 1,
                    onChanged: (int? value) {
                      _controller?.setIsLang(value ?? 1);
                    },
                    size: 20.0),
                const SizedBox(
                  height: 6,
                ),
                _customRadioButton(
                    child: const Text(
                      "English",
                    ),
                    value: 2,
                    groupValue: _controller?.isLang.value ?? 2,
                    onChanged: (int? value) {
                      _controller?.setIsLang(value ?? 2);
                    },
                    size: 20.0),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _controller?.saveLanguage(context);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: const BoxDecoration(
                        color: Color(0xff5c0751),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset:
                                Offset(0, 2.0), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)?.selectLanguage ??
                                "Select Language",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    ));
  }

  Widget _customRadioButton(
      {required Widget child,
      required int value,
      required int groupValue,
      required Function(int) onChanged,
      required double size}) {
    final isSelected = value == groupValue;

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: InkWell(
        onTap: () => onChanged(value),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: child,
              ),
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey,
                    width: 2.0,
                  ),
                  color: isSelected ? Colors.white : Colors.transparent,
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: size / 1.8,
                          height: size / 1.8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightBlue,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
