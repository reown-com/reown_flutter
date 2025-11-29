import 'dart:convert';

import 'package:eth_sig_util/util/utils.dart';
import 'package:reown_appkit/reown_appkit.dart' hide bytesToHex;

enum EIP155Methods {
  personalSign,
  ethSign,
  ethSignTypedData,
  ethSignTypedDataV4,
  ethSignTransaction,
  ethSendTransaction,
}

// enum EIP155Events {
//   none,
// }

class EIP155 {
  static final Map<EIP155Methods, String> methods = {
    EIP155Methods.personalSign: 'personal_sign',
    EIP155Methods.ethSign: 'eth_sign',
    EIP155Methods.ethSignTypedData: 'eth_signTypedData',
    EIP155Methods.ethSignTypedDataV4: 'eth_signTypedData_v4',
    EIP155Methods.ethSignTransaction: 'eth_signTransaction',
    EIP155Methods.ethSendTransaction: 'eth_sendTransaction',
  };

  static final List<String> events =
      NetworkUtils.defaultNetworkEvents['eip155']!.toList();

  static String personalSignMessage(String chain) {
    final bytes = utf8.encode('Welcome to Flutter AppKit on $chain');
    return bytesToHex(bytes, include0x: true);
  }

  static String typedData =
      r'''{"types":{"EIP712Domain":[{"type":"string","name":"name"},{"type":"string","name":"version"},{"type":"uint256","name":"chainId"},{"type":"address","name":"verifyingContract"}],"Part":[{"name":"account","type":"address"},{"name":"value","type":"uint96"}],"Mint721":[{"name":"tokenId","type":"uint256"},{"name":"tokenURI","type":"string"},{"name":"creators","type":"Part[]"},{"name":"royalties","type":"Part[]"}]},"domain":{"name":"Mint721","version":"1","chainId":4,"verifyingContract":"0x2547760120aed692eb19d22a5d9ccfe0f7872fce"},"primaryType":"Mint721","message":{"@type":"ERC721","contract":"0x2547760120aed692eb19d22a5d9ccfe0f7872fce","tokenId":"1","uri":"ipfs://ipfs/hash","creators":[{"account":"0xc5eac3488524d577a1495492599e8013b1f91efa","value":10000}],"royalties":[],"tokenURI":"ipfs://ipfs/hash"}}''';

  static Map<String, dynamic> typeDataV3(int chainId) => {
        'types': {
          'EIP712Domain': [
            {'name': 'name', 'type': 'string'},
            {'name': 'version', 'type': 'string'},
            {'name': 'chainId', 'type': 'uint256'},
            {'name': 'verifyingContract', 'type': 'address'},
          ],
          'Person': [
            {'name': 'name', 'type': 'string'},
            {'name': 'wallet', 'type': 'address'},
          ],
          'Mail': [
            {'name': 'from', 'type': 'Person'},
            {'name': 'to', 'type': 'Person'},
            {'name': 'contents', 'type': 'string'},
          ],
        },
        'primaryType': 'Mail',
        'domain': {
          'name': 'Ether Mail',
          'version': '1',
          'chainId': chainId,
          'verifyingContract': '0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC',
        },
        'message': {
          'from': {
            'name': 'Cow',
            'wallet': '0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826',
          },
          'to': {
            'name': 'Bob',
            'wallet': '0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB',
          },
          'contents': 'Hello, Bob!',
        },
      };

  static Map<String, dynamic> typeDataV4(int chainId) => {
        'types': {
          'EIP712Domain': [
            {'type': 'string', 'name': 'name'},
            {'type': 'string', 'name': 'version'},
            {'type': 'uint256', 'name': 'chainId'},
            {'type': 'address', 'name': 'verifyingContract'},
          ],
          'Part': [
            {'name': 'account', 'type': 'address'},
            {'name': 'value', 'type': 'uint96'},
          ],
          'Mint721': [
            {'name': 'tokenId', 'type': 'uint256'},
            {'name': 'tokenURI', 'type': 'string'},
            {'name': 'creators', 'type': 'Part[]'},
            {'name': 'royalties', 'type': 'Part[]'},
          ],
        },
        'domain': {
          'name': 'Mint721',
          'version': '1',
          'chainId': chainId,
          'verifyingContract': '0x2547760120aed692eb19d22a5d9ccfe0f7872fce',
        },
        'primaryType': 'Mint721',
        'message': {
          '@type': 'ERC721',
          'contract': '0x2547760120aed692eb19d22a5d9ccfe0f7872fce',
          'tokenId': '1',
          'uri': 'ipfs://ipfs/hash',
          'creators': [
            {
              'account': '0xc5eac3488524d577a1495492599e8013b1f91efa',
              'value': 10000,
            },
          ],
          'royalties': [],
          'tokenURI': 'ipfs://ipfs/hash',
        },
      };

  /// KADENA ///

  // SignRequest createSignRequest({
  //   required String networkId,
  //   required String signingPubKey,
  //   required String sender,
  //   String code = '"hello"',
  //   Map<String, dynamic>? data,
  //   List<DappCapp> caps = const [],
  //   String chainId = '1',
  //   int gasLimit = 2000,
  //   double gasPrice = 1e-8,
  //   int ttl = 600,
  // }) =>
  //     SignRequest(
  //       code: code,
  //       data: data ?? {},
  //       sender: sender,
  //       networkId: networkId,
  //       chainId: chainId,
  //       gasLimit: gasLimit,
  //       gasPrice: gasPrice,
  //       signingPubKey: signingPubKey,
  //       ttl: ttl,
  //       caps: caps,
  //     );

  // PactCommandPayload createPactCommandPayload({
  //   required String networkId,
  //   required String sender,
  //   String code = '"hello"',
  //   Map<String, dynamic>? data,
  //   List<SignerCapabilities> signerCaps = const [],
  //   String chainId = '1',
  //   int gasLimit = 2000,
  //   double gasPrice = 1e-8,
  //   int ttl = 600,
  // }) =>
  //     PactCommandPayload(
  //       networkId: networkId,
  //       payload: CommandPayload(
  //         exec: ExecMessage(
  //           code: code,
  //           data: data ?? {},
  //         ),
  //       ),
  //       signers: signerCaps,
  //       meta: CommandMetadata(
  //         chainId: chainId,
  //         gasLimit: gasLimit,
  //         gasPrice: gasPrice,
  //         ttl: ttl,
  //         sender: sender,
  //       ),
  //     );

  // QuicksignRequest createQuicksignRequest({
  //   required String cmd,
  //   List<QuicksignSigner> sigs = const [],
  // }) =>
  //     QuicksignRequest(
  //       commandSigDatas: [
  //         CommandSigData(
  //           cmd: cmd,
  //           sigs: sigs,
  //         ),
  //       ],
  //     );

  // GetAccountsRequest createGetAccountsRequest({
  //   required String account,
  // }) =>
  //     GetAccountsRequest(
  //       accounts: [
  //         AccountRequest(
  //           account: account,
  //         ),
  //       ],
  //     );

  /// KADENA ///

  // SignRequest createSignRequest({
  //   required String networkId,
  //   required String signingPubKey,
  //   required String sender,
  //   String code = '"hello"',
  //   Map<String, dynamic>? data,
  //   List<DappCapp> caps = const [],
  //   String chainId = '1',
  //   int gasLimit = 2000,
  //   double gasPrice = 1e-8,
  //   int ttl = 600,
  // }) =>
  //     SignRequest(
  //       code: code,
  //       data: data ?? {},
  //       sender: sender,
  //       networkId: networkId,
  //       chainId: chainId,
  //       gasLimit: gasLimit,
  //       gasPrice: gasPrice,
  //       signingPubKey: signingPubKey,
  //       ttl: ttl,
  //       caps: caps,
  //     );

  // PactCommandPayload createPactCommandPayload({
  //   required String networkId,
  //   required String sender,
  //   String code = '"hello"',
  //   Map<String, dynamic>? data,
  //   List<SignerCapabilities> signerCaps = const [],
  //   String chainId = '1',
  //   int gasLimit = 2000,
  //   double gasPrice = 1e-8,
  //   int ttl = 600,
  // }) =>
  //     PactCommandPayload(
  //       networkId: networkId,
  //       payload: CommandPayload(
  //         exec: ExecMessage(
  //           code: code,
  //           data: data ?? {},
  //         ),
  //       ),
  //       signers: signerCaps,
  //       meta: CommandMetadata(
  //         chainId: chainId,
  //         gasLimit: gasLimit,
  //         gasPrice: gasPrice,
  //         ttl: ttl,
  //         sender: sender,
  //       ),
  //     );

  // QuicksignRequest createQuicksignRequest({
  //   required String cmd,
  //   List<QuicksignSigner> sigs = const [],
  // }) =>
  //     QuicksignRequest(
  //       commandSigDatas: [
  //         CommandSigData(
  //           cmd: cmd,
  //           sigs: sigs,
  //         ),
  //       ],
  //     );

  // GetAccountsRequest createGetAccountsRequest({
  //   required String account,
  // }) =>
  //     GetAccountsRequest(
  //       accounts: [
  //         AccountRequest(
  //           account: account,
  //         ),
  //       ],
  //     );
}
