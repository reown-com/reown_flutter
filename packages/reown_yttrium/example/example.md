# Reown Yttrium Example

This example demonstrates how to use the Reown Yttrium plugin in a Flutter application to interact with smart accounts and perform blockchain operations.

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:reown_yttrium/reown_yttrium.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reown Yttrium Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _reownYttrium = ReownYttrium();
  String _balance = 'Not checked';
  String _fees = 'Not estimated';
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeYttrium();
  }

  Future<void> _initializeYttrium() async {
    try {
      final success = await _reownYttrium.init(
        projectId: 'your_project_id',
        pulseMetadata: PulseMetadataCompat(
          name: 'Example App',
          description: 'A demo app using Reown Yttrium',
          url: 'https://example.com',
          icons: ['https://example.com/icon.png'],
        ),
      );
      
      if (success) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      print('Failed to initialize Yttrium: $e');
    }
  }

  Future<void> _checkTokenBalance() async {
    try {
      final balance = await _reownYttrium.erc20TokenBalance(
        chainId: '1', // Ethereum mainnet
        token: '0x...', // ERC20 token address
        owner: '0x...', // Wallet address
      );
      
      setState(() {
        _balance = balance;
      });
    } catch (e) {
      print('Failed to check balance: $e');
    }
  }

  Future<void> _estimateFees() async {
    try {
      final fees = await _reownYttrium.estimateFees(
        chainId: 'eip155:1', // Ethereum mainnet
      );
      
      setState(() {
        _fees = 'Max Fee: ${fees.maxFeePerGas}\n'
                'Max Priority Fee: ${fees.maxPriorityFeePerGas}';
      });
    } catch (e) {
      print('Failed to estimate fees: $e');
    }
  }

  Future<void> _prepareAndExecuteTransaction() async {
    try {
      // Prepare the transaction
      final preparedTx = await _reownYttrium.prepareDetailed(
        chainId: 'eip155:x',
        from: '0x...', // Sender address
        call: CallCompat(
          to: '0x...', // Token address
          data: '0x', // Contract Call data
        ),
      );

      // Execute the transaction
      final executionDetails = await _reownYttrium.execute(
        uiFields: preparedTx.uiFields,
        routeTxnSigs: preparedTx.routeTxnSigs,
        initialTxnSig: preparedTx.initialTxnSig,
      );

      print('Transaction executed: ${executionDetails.hash}');
    } catch (e) {
      print('Failed to execute transaction: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reown Yttrium Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Yttrium Status: ${_isInitialized ? 'Initialized' : 'Not Initialized'}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isInitialized ? _checkTokenBalance : null,
              child: const Text('Check Token Balance'),
            ),
            Text('Balance: $_balance'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isInitialized ? _estimateFees : null,
              child: const Text('Estimate Transaction Fees'),
            ),
            Text('Fees: $_fees'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isInitialized ? _prepareAndExecuteTransaction : null,
              child: const Text('Send Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Key Features Demonstrated

1. **Initialization**
   - Initializes the Yttrium plugin with project ID and metadata
   - Handles initialization errors gracefully

2. **Token Balance Checking**
   - Checks ERC20 token balance for a specific address
   - Displays the balance in the UI

3. **Fee Estimation**
   - Estimates EIP-1559 transaction fees
   - Shows both max fee and priority fee

4. **Transaction Preparation and Execution**
   - Prepares a transaction with detailed parameters
   - Executes the transaction with proper signatures
   - Handles transaction execution errors

## Error Handling

The example includes basic error handling for all operations. In a production environment, you should:

1. Implement more robust error handling
2. Add loading states for async operations
3. Implement proper error messages in the UI
4. Add retry mechanisms for failed operations

## Best Practices

1. Always initialize the plugin before using any features
2. Handle all async operations with proper error handling
3. Update the UI state appropriately for async operations
4. Use proper type safety and null checking
5. Implement proper state management for larger applications

## Running the Example

1. Create a new Flutter project
2. Add the Reown Yttrium dependency to your `pubspec.yaml`
3. Copy the example code to your project
4. Replace placeholder values (project ID, addresses, etc.) with your actual values
5. Run the application

Remember to handle sensitive information (like private keys and API keys) securely in a production environment.
