import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:we_chat_simple_app/consts/colors.dart';
import 'package:we_chat_simple_app/consts/dimes.dart';
import 'package:we_chat_simple_app/data/apply/wechat_simple_apply.dart';
import 'package:we_chat_simple_app/pages/bottom_navigation_page.dart';
import 'package:we_chat_simple_app/utils/extension.dart';
import 'package:we_chat_simple_app/widgets/easy_text_widget.dart';

import '../consts/strings.dart';
import '../data/apply/wechat_simple_apply_Impl.dart';
import '../data/vos/user_vo.dart';
import '../utils/images.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({Key? key, required this.currentUser}) : super(key: key);

  final UserVO? currentUser;

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? qrViewController;

  Barcode? barcode;

  final WeChatSimpleApply _weChatSimpleApply = WeChatSimpleApplyImpl();

  UserVO? friendUserV0;
  String? friendQrCode = '';
  UserVO? currentUserVO;
  String? currentUserQrCode = '';

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await qrViewController!.pauseCamera();
    }
    qrViewController!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                context.navigateBack(context);
              },
              child: const Icon(Icons.close)),
        ),
        backgroundColor: kBlackColor,
        body: Stack(
          alignment: Alignment.center,
          children: [
            buildQrView(context),
            Positioned(bottom: kSP10x, child: buildResult()),
            Positioned(top: kSP10x, child: buildControlButton())
          ],
        ),
      ),
    );
  }

  Widget buildControlButton() => Container(
        padding: const EdgeInsets.symmetric(horizontal: kSP16x),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius8x),
            color: kWhite24Color),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: FutureBuilder<bool?>(
                future: qrViewController?.getFlashStatus(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(
                        snapshot.data! ? Icons.flash_on : Icons.flash_off);
                  }
                  return Container();
                },
              ),
              onPressed: () async {
                await qrViewController?.toggleFlash();
                setState(() {});
              },
            ),
            IconButton(
              icon: FutureBuilder(
                future: qrViewController?.getCameraInfo(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return const Icon(Icons.switch_camera);
                  }
                  return Container();
                },
              ),
              onPressed: () async {
                await qrViewController?.flipCamera();
                setState(() {});
              },
            )
          ],
        ),
      );

  Widget buildResult() => Container(
        padding: const EdgeInsets.all(kSP12x),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius8x),
            color: kWhite24Color),
        child: Text(
          barcode != null ? " ${barcode!.code}" : kScanCodeText,
          maxLines: 3,
        ),
      );

  Widget buildQrView(BuildContext context) => QRView(
      overlay: QrScannerOverlayShape(
        borderColor: kGreenColor,
        borderLength: kQrViewBorderLength20x,
        borderRadius: kQrViewBorderRadius10x,
        borderWidth: kQrViewBorderWidth10x,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
      key: qrKey,
      onQRViewCreated: onQRViewCreated);

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      qrViewController = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
        friendQrCode = barcode.code ?? '';
      });

      currentUserQrCode = widget.currentUser?.id ?? '';
      _weChatSimpleApply.getUserVO(currentUserQrCode!).then((value) {
        currentUserVO = value;
      });

      _weChatSimpleApply.getUserVO(friendQrCode!).then((value) {
        friendUserV0 = value;
      });

      showDialog(
        context: context,
        builder: (context) => FriendRequestItemView(
            friendUserV0: friendUserV0,
            weChatSimpleApply: _weChatSimpleApply,
            friendQrCode: friendQrCode,
            currentUserVO: currentUserVO,
            currentUserQrCode: currentUserQrCode),
      );
    });
  }
}

class FriendRequestItemView extends StatelessWidget {
  const FriendRequestItemView({
    super.key,
    required this.friendUserV0,
    required WeChatSimpleApply weChatSimpleApply,
    required this.friendQrCode,
    required this.currentUserVO,
    required this.currentUserQrCode,
  }) : _weChatSimpleApply = weChatSimpleApply;

  final UserVO? friendUserV0;
  final WeChatSimpleApply _weChatSimpleApply;
  final String? friendQrCode;
  final UserVO? currentUserVO;
  final String? currentUserQrCode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: kWhiteColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(kSP5x),
              child: CircleAvatar(
                radius: kCircleAvatarRadius40x,
                backgroundImage: NetworkImage(
                    (friendUserV0?.file == null || friendUserV0?.file == "")
                        ? kDefaultImage
                        : friendUserV0?.file ?? kDefaultImage),
              ),
            ),
            const SizedBox(
              width: kSP10x,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EasyTextWidget(
                  text: friendUserV0?.name ?? '',
                  textColor: kBlackColor,
                  fontSize: kFontSize15x,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: kSP5x,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        _weChatSimpleApply
                            .setContacts(friendQrCode!, currentUserVO!)
                            .catchError((error) => ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: EasyTextWidget(
                                  text: '$error',
                                ))));

                        _weChatSimpleApply
                            .setContacts(currentUserQrCode!, friendUserV0!)
                            .catchError((error) => ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: EasyTextWidget(
                                  text: '$error',
                                ))));

                        context.navigateToNextScreen(
                            context, const BottomNavPage());
                      },
                      color: kGreenColor,
                      child: const EasyTextWidget(
                        text: kConfirmText,
                      ),
                    ),
                    const SizedBox(
                      width: kSP10x,
                    ),
                    MaterialButton(
                      onPressed: () {
                        context.navigateBack(context);
                        context.navigateBack(context);
                      },
                      color: kWhite24Color,
                      child: const EasyTextWidget(
                        text: kDeleteText,
                        textColor: kBlackColor,
                      ),
                    ),
                    const SizedBox(
                      width: kSP10x,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
