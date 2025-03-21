import 'dart:async';

import 'package:flutter/material.dart';
import 'package:poc_wallet_connect/deep_link_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reown_appkit/reown_appkit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ReownAppKitModal? _appKitModal;

  Future<void> connectWallet(BuildContext context) async {}

  void printWallet() {
    ReownAppKitModalNetworkInfo(
      chainId: '11155111',
      name: 'Sepolia',
      currency: 'ETH',
      rpcUrl: 'https://1rpc.io/sepolia',
      explorerUrl: 'https://sepolia.etherscan.io/',
    );
  }

  void transaction() {}

  void createReown(BuildContext context) async {
    // AppKit instance
    ReownAppKit reownAppKit = await ReownAppKit.createInstance(
      projectId: '0472f752565b5de1c6d4a6f222e665ab',
      metadata: const PairingMetadata(
        name: 'Example App',
        description: 'Example app description',
        url: '',
        icons: [''],
        redirect: Redirect(
          native: 'poc_wallet_connect://',
          linkMode: false,
        ),
      ),
    );
    const String url = 'https://github.com/FelipeLemosBellini';
    _appKitModal = ReownAppKitModal(
      context: context,
      projectId: '',
      metadata: const PairingMetadata(
        name: 'Starkwager',
        description: 'A decentralized wagering platform',
        url: url,
        icons: <String>[],
        redirect: Redirect(universal: url, native: url),
      ),
    );
    debugPrint("🔄 Initializing AppKitModal...");
    await _appKitModal?.init();
    debugPrint("✅ AppKitModal Initialized Successfully!");
    await _appKitModal?.selectChain(
      ReownAppKitModalNetworkInfo(
        chainId: '11155111',
        name: 'Sepolia',
        currency: 'ETH',
        rpcUrl: 'https://1rpc.io/sepolia',
        explorerUrl: 'https://sepolia.etherscan.io/',
      ),
    );
    // ReownAppKitModal(
    //   context: context,
    //   appKit: reownAppKit,
    //   projectId: '',
    //   metadata: const PairingMetadata(
    //     name: 'Example App',
    //     description: 'Example app description',
    //     url: '',
    //     icons: [''],
    //     redirect: Redirect(
    //       native: 'poc_wallet_connect://',
    //       universal: "https://reown.com/exampleapp",
    //       linkMode: true,
    //     ),
    //   ),
    //   requiredNamespaces: const {
    //     'eip155': RequiredNamespace(
    //       chains: ['eip155:11155111'], // Ethereum mainnet
    //       methods: ['eth_sendTransaction', 'personal_sign'],
    //       events: [
    //         'chainChanged',
    //         'accountsChanged',
    //         'eth_signTypedData_v4',
    //         'personal_sign',
    //         'eth_signTypedData_v3',
    //         'eth_signTypedData',
    //         'eth_signTransaction',
    //       ],
    //     ),
    //   },
    //   siweConfig: SIWEConfig(
    //     getNonce: () async {
    //       return SIWEUtils.generateNonce();
    //     },
    //     getMessageParams: () async {
    //       return SIWEMessageArgs(
    //         domain: Uri.parse(_appKitModal?.appKit!.metadata.url ?? "").authority,
    //         uri: _appKitModal?.appKit!.metadata.url ?? "",
    //         statement: '{Your custom message here}',
    //         methods: MethodsConstants.allMethods,
    //       );
    //     },
    //     createMessage: (SIWECreateMessageArgs args) {
    //       return SIWEUtils.formatMessage(args);
    //     },
    //     verifyMessage: (SIWEVerifyMessageArgs args) async {
    //       final chainId = SIWEUtils.getChainIdFromMessage(args.message);
    //       final address = SIWEUtils.getAddressFromMessage(args.message);
    //       final cacaoSignature = args.cacao != null
    //           ? args.cacao!.s
    //           : CacaoSignature(
    //               t: CacaoSignature.EIP191,
    //               s: args.signature,
    //             );
    //       return await SIWEUtils.verifySignature(
    //         address,
    //         args.message,
    //         cacaoSignature,
    //         chainId,
    //         coloca o id do reown,
    //       );
    //     },
    //     getSession: () async {
    //       final chainId = _appKitModal?.selectedChain?.chainId ?? '1';
    //       final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
    //         chainId,
    //       );
    //       final address = _appKitModal?.session!.getAddress(namespace)!;
    //       return SIWESession(address: address ?? "", chains: [chainId]);
    //     },
    //     signOut: () async {
    //       return true;
    //     },
    //   ),
    // );

    _appKitModal?.onModalConnect.subscribe((ModalConnect? event) {
      print("ssssssssssssss");
      print(event?.session.getAddress('eip155'));
    });

    _appKitModal?.onModalError.subscribe((ModalError? event) {
      print("ssssssssssssss");
      print(event?.message);
    });

    await _appKitModal?.init();
    DeepLinkHandler.init(_appKitModal!);
    DeepLinkHandler.checkInitialLink();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text(_deepLink),
          _appKitModal != null
              ? AppKitModalConnectButton(
                  appKit: _appKitModal!,
                  context: context,
                )
              : const SizedBox.shrink(),
          _appKitModal != null
              ? AppKitModalNetworkSelectButton(
                  appKit: _appKitModal!,
                  context: context,
                )
              : const SizedBox.shrink(),
          ElevatedButton(
            onPressed: () {
              connectWallet.call(context);
            },
            child: Text("connectWallet"),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              printWallet.call();
            },
            child: Text("printWallet"),
          ),
          ElevatedButton(
            onPressed: () {
              transaction.call();
            },
            child: Text("transaction"),
          ),
          ElevatedButton(
            onPressed: () {
              createReown.call(context);
            },
            child: Text("createReown"),
          ),


        ],
      ),
    );
  }
}
