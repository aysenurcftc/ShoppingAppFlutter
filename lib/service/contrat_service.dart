import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class CouponService {
  final String _rpcUrl = "https://goerli.infura.io/v3/e52c87a01e1a4a06811039fb2ef29ba2";
  final String _contractAddress = "0xd9145CCE52D386f254917e481eB44e9943F39138";
  final String _privateKey = "0x73fe06313dD9750998FBe0907A5117f48f45cB1C";

  late Web3Client client;
  late DeployedContract contract;
  late Credentials credentials;

  CouponService() {
    client = Web3Client(_rpcUrl, http.Client());
    contract = DeployedContract(
      ContractAbi.fromJson(
        '[{"constant":false,"inputs":[{"name":"user","type":"address"}],"name":"useCoupon","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}]',
        'CouponContract',
      ),
      EthereumAddress.fromHex(_contractAddress),
    );
    credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> useCoupon(String userAddress) async {
    await client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: contract.function('useCoupon'),
        parameters: [EthereumAddress.fromHex(userAddress)],
      ),
    );
  }





}