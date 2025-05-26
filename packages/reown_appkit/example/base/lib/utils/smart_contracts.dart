abstract class SmartContract {
  String get name;
  String get contractAddress;
  List<Map<String, dynamic>> get contractABI;
}

class SepoliaAAVEContract implements SmartContract {
  @override
  String get name => 'AAVE-SEP';

  // https://sepolia.etherscan.io/token/0x88541670E55cC00bEEFD87eB59EDd1b7C511AC9a
  @override
  String get contractAddress => '0x88541670E55cC00bEEFD87eB59EDd1b7C511AC9a';

  @override
  List<Map<String, dynamic>> get contractABI => [
        {
          'inputs': [
            {'internalType': 'string', 'name': 'name', 'type': 'string'},
            {'internalType': 'string', 'name': 'symbol', 'type': 'string'},
            {'internalType': 'uint8', 'name': 'decimals', 'type': 'uint8'},
            {'internalType': 'address', 'name': 'owner', 'type': 'address'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'constructor'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'owner',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'spender',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Approval',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'previousOwner',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'newOwner',
              'type': 'address'
            }
          ],
          'name': 'OwnershipTransferred',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'from',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'to',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Transfer',
          'type': 'event'
        },
        {
          'inputs': [],
          'name': 'DOMAIN_SEPARATOR',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'EIP712_REVISION',
          'outputs': [
            {'internalType': 'bytes', 'name': '', 'type': 'bytes'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'PERMIT_TYPEHASH',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'}
          ],
          'name': 'allowance',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'approve',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'}
          ],
          'name': 'balanceOf',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'decimals',
          'outputs': [
            {'internalType': 'uint8', 'name': '', 'type': 'uint8'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {
              'internalType': 'uint256',
              'name': 'subtractedValue',
              'type': 'uint256'
            }
          ],
          'name': 'decreaseAllowance',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'addedValue', 'type': 'uint256'}
          ],
          'name': 'increaseAllowance',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'mint',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'mint',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'name',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'}
          ],
          'name': 'nonces',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'owner',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            {'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
            {'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
            {'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
          ],
          'name': 'permit',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'renounceOwnership',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'symbol',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'totalSupply',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'recipient', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'transfer',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'sender', 'type': 'address'},
            {'internalType': 'address', 'name': 'recipient', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'transferFrom',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'newOwner', 'type': 'address'}
          ],
          'name': 'transferOwnership',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        }
      ];
}

class ArbitrumAAVEContract implements SmartContract {
  @override
  String get name => 'AAVE-ARB';

  // https://arbiscan.io/address/0xba5ddd1f9d7f570dc94a51479a000e3bce967196
  @override
  String get contractAddress => '0xba5ddd1f9d7f570dc94a51479a000e3bce967196';

  @override
  List<Map<String, dynamic>> get contractABI => [
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'owner',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'spender',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Approval',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'from',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'to',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            },
            {
              'indexed': false,
              'internalType': 'bytes',
              'name': 'data',
              'type': 'bytes'
            }
          ],
          'name': 'Transfer',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'from',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'to',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Transfer',
          'type': 'event'
        },
        {
          'inputs': [],
          'name': 'DOMAIN_SEPARATOR',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'}
          ],
          'name': 'allowance',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'approve',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'}
          ],
          'name': 'balanceOf',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'bridgeBurn',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': '_l1Address',
              'type': 'address'
            },
            {'internalType': 'bytes', 'name': '_data', 'type': 'bytes'}
          ],
          'name': 'bridgeInit',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'bridgeMint',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'decimals',
          'outputs': [
            {'internalType': 'uint8', 'name': '', 'type': 'uint8'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {
              'internalType': 'uint256',
              'name': 'subtractedValue',
              'type': 'uint256'
            }
          ],
          'name': 'decreaseAllowance',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'addedValue', 'type': 'uint256'}
          ],
          'name': 'increaseAllowance',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'isMaster',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'l1Address',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'l2Gateway',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'name',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'}
          ],
          'name': 'nonces',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            {'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
            {'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
            {'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
          ],
          'name': 'permit',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'symbol',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'totalSupply',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'recipient', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'transfer',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': '_to', 'type': 'address'},
            {'internalType': 'uint256', 'name': '_value', 'type': 'uint256'},
            {'internalType': 'bytes', 'name': '_data', 'type': 'bytes'}
          ],
          'name': 'transferAndCall',
          'outputs': [
            {'internalType': 'bool', 'name': 'success', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'sender', 'type': 'address'},
            {'internalType': 'address', 'name': 'recipient', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'transferFrom',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        }
      ];
}

class BASEUSDCContract implements SmartContract {
  @override
  String get name => 'USDC-BASE';

  // https://basescan.org/token/0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
  @override
  String get contractAddress => '0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913';

  @override
  List<Map<String, dynamic>> get contractABI => [
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'owner',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'spender',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Approval',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'authorizer',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'bytes32',
              'name': 'nonce',
              'type': 'bytes32'
            }
          ],
          'name': 'AuthorizationCanceled',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'authorizer',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'bytes32',
              'name': 'nonce',
              'type': 'bytes32'
            }
          ],
          'name': 'AuthorizationUsed',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': '_account',
              'type': 'address'
            }
          ],
          'name': 'Blacklisted',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'newBlacklister',
              'type': 'address'
            }
          ],
          'name': 'BlacklisterChanged',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'burner',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'amount',
              'type': 'uint256'
            }
          ],
          'name': 'Burn',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'newMasterMinter',
              'type': 'address'
            }
          ],
          'name': 'MasterMinterChanged',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'minter',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'to',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'amount',
              'type': 'uint256'
            }
          ],
          'name': 'Mint',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'minter',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'minterAllowedAmount',
              'type': 'uint256'
            }
          ],
          'name': 'MinterConfigured',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'oldMinter',
              'type': 'address'
            }
          ],
          'name': 'MinterRemoved',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': false,
              'internalType': 'address',
              'name': 'previousOwner',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'address',
              'name': 'newOwner',
              'type': 'address'
            }
          ],
          'name': 'OwnershipTransferred',
          'type': 'event'
        },
        {'anonymous': false, 'inputs': [], 'name': 'Pause', 'type': 'event'},
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'newAddress',
              'type': 'address'
            }
          ],
          'name': 'PauserChanged',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'newRescuer',
              'type': 'address'
            }
          ],
          'name': 'RescuerChanged',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'from',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'to',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Transfer',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': '_account',
              'type': 'address'
            }
          ],
          'name': 'UnBlacklisted',
          'type': 'event'
        },
        {'anonymous': false, 'inputs': [], 'name': 'Unpause', 'type': 'event'},
        {
          'inputs': [],
          'name': 'CANCEL_AUTHORIZATION_TYPEHASH',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'DOMAIN_SEPARATOR',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'PERMIT_TYPEHASH',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'RECEIVE_WITH_AUTHORIZATION_TYPEHASH',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'TRANSFER_WITH_AUTHORIZATION_TYPEHASH',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'}
          ],
          'name': 'allowance',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'approve',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': 'authorizer',
              'type': 'address'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'}
          ],
          'name': 'authorizationState',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'}
          ],
          'name': 'balanceOf',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': '_account', 'type': 'address'}
          ],
          'name': 'blacklist',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'blacklister',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'uint256', 'name': '_amount', 'type': 'uint256'}
          ],
          'name': 'burn',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': 'authorizer',
              'type': 'address'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'},
            {'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
            {'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
            {'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
          ],
          'name': 'cancelAuthorization',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': 'authorizer',
              'type': 'address'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'},
            {'internalType': 'bytes', 'name': 'signature', 'type': 'bytes'}
          ],
          'name': 'cancelAuthorization',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'minter', 'type': 'address'},
            {
              'internalType': 'uint256',
              'name': 'minterAllowedAmount',
              'type': 'uint256'
            }
          ],
          'name': 'configureMinter',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'currency',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'decimals',
          'outputs': [
            {'internalType': 'uint8', 'name': '', 'type': 'uint8'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'decrement', 'type': 'uint256'}
          ],
          'name': 'decreaseAllowance',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'increment', 'type': 'uint256'}
          ],
          'name': 'increaseAllowance',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'string', 'name': 'tokenName', 'type': 'string'},
            {'internalType': 'string', 'name': 'tokenSymbol', 'type': 'string'},
            {
              'internalType': 'string',
              'name': 'tokenCurrency',
              'type': 'string'
            },
            {'internalType': 'uint8', 'name': 'tokenDecimals', 'type': 'uint8'},
            {
              'internalType': 'address',
              'name': 'newMasterMinter',
              'type': 'address'
            },
            {'internalType': 'address', 'name': 'newPauser', 'type': 'address'},
            {
              'internalType': 'address',
              'name': 'newBlacklister',
              'type': 'address'
            },
            {'internalType': 'address', 'name': 'newOwner', 'type': 'address'}
          ],
          'name': 'initialize',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'string', 'name': 'newName', 'type': 'string'}
          ],
          'name': 'initializeV2',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': 'lostAndFound',
              'type': 'address'
            }
          ],
          'name': 'initializeV2_1',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {
              'internalType': 'address[]',
              'name': 'accountsToBlacklist',
              'type': 'address[]'
            },
            {'internalType': 'string', 'name': 'newSymbol', 'type': 'string'}
          ],
          'name': 'initializeV2_2',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': '_account', 'type': 'address'}
          ],
          'name': 'isBlacklisted',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'}
          ],
          'name': 'isMinter',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'masterMinter',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': '_to', 'type': 'address'},
            {'internalType': 'uint256', 'name': '_amount', 'type': 'uint256'}
          ],
          'name': 'mint',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'minter', 'type': 'address'}
          ],
          'name': 'minterAllowance',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'name',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'}
          ],
          'name': 'nonces',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'owner',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'pause',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'paused',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'pauser',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            {'internalType': 'bytes', 'name': 'signature', 'type': 'bytes'}
          ],
          'name': 'permit',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            {'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
            {'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
            {'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
          ],
          'name': 'permit',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'from', 'type': 'address'},
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {
              'internalType': 'uint256',
              'name': 'validAfter',
              'type': 'uint256'
            },
            {
              'internalType': 'uint256',
              'name': 'validBefore',
              'type': 'uint256'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'},
            {'internalType': 'bytes', 'name': 'signature', 'type': 'bytes'}
          ],
          'name': 'receiveWithAuthorization',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'from', 'type': 'address'},
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {
              'internalType': 'uint256',
              'name': 'validAfter',
              'type': 'uint256'
            },
            {
              'internalType': 'uint256',
              'name': 'validBefore',
              'type': 'uint256'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'},
            {'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
            {'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
            {'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
          ],
          'name': 'receiveWithAuthorization',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'minter', 'type': 'address'}
          ],
          'name': 'removeMinter',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {
              'internalType': 'contract IERC20',
              'name': 'tokenContract',
              'type': 'address'
            },
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'rescueERC20',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'rescuer',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'symbol',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'totalSupply',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'transfer',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'from', 'type': 'address'},
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'transferFrom',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'newOwner', 'type': 'address'}
          ],
          'name': 'transferOwnership',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'from', 'type': 'address'},
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {
              'internalType': 'uint256',
              'name': 'validAfter',
              'type': 'uint256'
            },
            {
              'internalType': 'uint256',
              'name': 'validBefore',
              'type': 'uint256'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'},
            {'internalType': 'bytes', 'name': 'signature', 'type': 'bytes'}
          ],
          'name': 'transferWithAuthorization',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'from', 'type': 'address'},
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {
              'internalType': 'uint256',
              'name': 'validAfter',
              'type': 'uint256'
            },
            {
              'internalType': 'uint256',
              'name': 'validBefore',
              'type': 'uint256'
            },
            {'internalType': 'bytes32', 'name': 'nonce', 'type': 'bytes32'},
            {'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
            {'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
            {'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
          ],
          'name': 'transferWithAuthorization',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': '_account', 'type': 'address'}
          ],
          'name': 'unBlacklist',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'unpause',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': '_newBlacklister',
              'type': 'address'
            }
          ],
          'name': 'updateBlacklister',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': '_newMasterMinter',
              'type': 'address'
            }
          ],
          'name': 'updateMasterMinter',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': '_newPauser', 'type': 'address'}
          ],
          'name': 'updatePauser',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'newRescuer', 'type': 'address'}
          ],
          'name': 'updateRescuer',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'version',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'pure',
          'type': 'function'
        }
      ];
}

class SepoliaTestContract implements SmartContract {
  // Alfreedoms2 ALF2 in Sepolia
  // DEPLOY https://sepolia.etherscan.io/tx/0xebf287281abbc976b7cf6956a7f5f66338935d324c6453a350e3bb42ff7bd4e2
  // MINT https://sepolia.etherscan.io/tx/0x04a015504be7420a40a59936bfcca9302e55700fd00129059444539770fed5e7
  // CONTRACT https://sepolia.etherscan.io/address/0xBe60D05C11BD1C365849C824E0C2D880d2466eAF
  // TRANSFERS https://sepolia.etherscan.io/token/0xbe60d05c11bd1c365849c824e0c2d880d2466eaf?a=0x59e2f66C0E96803206B6486cDb39029abAE834c0
  // SOURCIFY https://repo.sourcify.dev/contracts/full_match/11155111/0xBe60D05C11BD1C365849C824E0C2D880d2466eAF/

  @override
  String get name => 'ALF2-SEP';

  @override
  String get contractAddress => '0xBe60D05C11BD1C365849C824E0C2D880d2466eAF';

  @override
  List<Map<String, dynamic>> get contractABI => [
        {
          'inputs': [
            {
              'internalType': 'address',
              'name': 'initialOwner',
              'type': 'address'
            }
          ],
          'stateMutability': 'nonpayable',
          'type': 'constructor'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'allowance', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'needed', 'type': 'uint256'}
          ],
          'name': 'ERC20InsufficientAllowance',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'sender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'balance', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'needed', 'type': 'uint256'}
          ],
          'name': 'ERC20InsufficientBalance',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'approver', 'type': 'address'}
          ],
          'name': 'ERC20InvalidApprover',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'receiver', 'type': 'address'}
          ],
          'name': 'ERC20InvalidReceiver',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'sender', 'type': 'address'}
          ],
          'name': 'ERC20InvalidSender',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'}
          ],
          'name': 'ERC20InvalidSpender',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'}
          ],
          'name': 'OwnableInvalidOwner',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'}
          ],
          'name': 'OwnableUnauthorizedAccount',
          'type': 'error'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'owner',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'spender',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Approval',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'previousOwner',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'newOwner',
              'type': 'address'
            }
          ],
          'name': 'OwnershipTransferred',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'from',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'to',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Transfer',
          'type': 'event'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'}
          ],
          'name': 'allowance',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'approve',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'}
          ],
          'name': 'balanceOf',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'decimals',
          'outputs': [
            {'internalType': 'uint8', 'name': '', 'type': 'uint8'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'mint',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'name',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'owner',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'renounceOwnership',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'symbol',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'totalSupply',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'transfer',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'from', 'type': 'address'},
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'transferFrom',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'newOwner', 'type': 'address'}
          ],
          'name': 'transferOwnership',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        }
      ];
}

class ERC20USDTContract implements SmartContract {
  @override
  String get name => 'USDT-ERC20';

  // https://etherscan.io/token/0xdac17f958d2ee523a2206206994597c13d831ec7
  @override
  String get contractAddress => '0xdAC17F958D2ee523a2206206994597C13D831ec7';

  @override
  List<Map<String, dynamic>> get contractABI => [
        {
          'constant': true,
          'inputs': [],
          'name': 'name',
          'outputs': [
            {'name': '', 'type': 'string'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [
            {'name': '_upgradedAddress', 'type': 'address'}
          ],
          'name': 'deprecate',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [
            {'name': '_spender', 'type': 'address'},
            {'name': '_value', 'type': 'uint256'}
          ],
          'name': 'approve',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [],
          'name': 'deprecated',
          'outputs': [
            {'name': '', 'type': 'bool'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [
            {'name': '_evilUser', 'type': 'address'}
          ],
          'name': 'addBlackList',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [],
          'name': 'totalSupply',
          'outputs': [
            {'name': '', 'type': 'uint256'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [
            {'name': '_from', 'type': 'address'},
            {'name': '_to', 'type': 'address'},
            {'name': '_value', 'type': 'uint256'}
          ],
          'name': 'transferFrom',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [],
          'name': 'upgradedAddress',
          'outputs': [
            {'name': '', 'type': 'address'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [
            {'name': '', 'type': 'address'}
          ],
          'name': 'balances',
          'outputs': [
            {'name': '', 'type': 'uint256'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [],
          'name': 'decimals',
          'outputs': [
            {'name': '', 'type': 'uint256'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [],
          'name': 'maximumFee',
          'outputs': [
            {'name': '', 'type': 'uint256'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [],
          'name': '_totalSupply',
          'outputs': [
            {'name': '', 'type': 'uint256'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [],
          'name': 'unpause',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [
            {'name': '_maker', 'type': 'address'}
          ],
          'name': 'getBlackListStatus',
          'outputs': [
            {'name': '', 'type': 'bool'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [
            {'name': '', 'type': 'address'},
            {'name': '', 'type': 'address'}
          ],
          'name': 'allowed',
          'outputs': [
            {'name': '', 'type': 'uint256'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [],
          'name': 'paused',
          'outputs': [
            {'name': '', 'type': 'bool'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [
            {'name': 'who', 'type': 'address'}
          ],
          'name': 'balanceOf',
          'outputs': [
            {'name': '', 'type': 'uint256'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [],
          'name': 'pause',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [],
          'name': 'getOwner',
          'outputs': [
            {'name': '', 'type': 'address'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [],
          'name': 'owner',
          'outputs': [
            {'name': '', 'type': 'address'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [],
          'name': 'symbol',
          'outputs': [
            {'name': '', 'type': 'string'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [
            {'name': '_to', 'type': 'address'},
            {'name': '_value', 'type': 'uint256'}
          ],
          'name': 'transfer',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [
            {'name': 'newBasisPoints', 'type': 'uint256'},
            {'name': 'newMaxFee', 'type': 'uint256'}
          ],
          'name': 'setParams',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [
            {'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'issue',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [
            {'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'redeem',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [
            {'name': '_owner', 'type': 'address'},
            {'name': '_spender', 'type': 'address'}
          ],
          'name': 'allowance',
          'outputs': [
            {'name': 'remaining', 'type': 'uint256'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [],
          'name': 'basisPointsRate',
          'outputs': [
            {'name': '', 'type': 'uint256'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [
            {'name': '', 'type': 'address'}
          ],
          'name': 'isBlackListed',
          'outputs': [
            {'name': '', 'type': 'bool'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [
            {'name': '_clearedUser', 'type': 'address'}
          ],
          'name': 'removeBlackList',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [],
          'name': 'MAX_UINT',
          'outputs': [
            {'name': '', 'type': 'uint256'}
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [
            {'name': 'newOwner', 'type': 'address'}
          ],
          'name': 'transferOwnership',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [
            {'name': '_blackListedUser', 'type': 'address'}
          ],
          'name': 'destroyBlackFunds',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'name': '_initialSupply', 'type': 'uint256'},
            {'name': '_name', 'type': 'string'},
            {'name': '_symbol', 'type': 'string'},
            {'name': '_decimals', 'type': 'uint256'}
          ],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'constructor'
        },
        {
          'anonymous': false,
          'inputs': [
            {'indexed': false, 'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'Issue',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {'indexed': false, 'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'Redeem',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {'indexed': false, 'name': 'newAddress', 'type': 'address'}
          ],
          'name': 'Deprecate',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {'indexed': false, 'name': 'feeBasisPoints', 'type': 'uint256'},
            {'indexed': false, 'name': 'maxFee', 'type': 'uint256'}
          ],
          'name': 'Params',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {'indexed': false, 'name': '_blackListedUser', 'type': 'address'},
            {'indexed': false, 'name': '_balance', 'type': 'uint256'}
          ],
          'name': 'DestroyedBlackFunds',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {'indexed': false, 'name': '_user', 'type': 'address'}
          ],
          'name': 'AddedBlackList',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {'indexed': false, 'name': '_user', 'type': 'address'}
          ],
          'name': 'RemovedBlackList',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {'indexed': true, 'name': 'owner', 'type': 'address'},
            {'indexed': true, 'name': 'spender', 'type': 'address'},
            {'indexed': false, 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'Approval',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {'indexed': true, 'name': 'from', 'type': 'address'},
            {'indexed': true, 'name': 'to', 'type': 'address'},
            {'indexed': false, 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'Transfer',
          'type': 'event'
        },
        {'anonymous': false, 'inputs': [], 'name': 'Pause', 'type': 'event'},
        {'anonymous': false, 'inputs': [], 'name': 'Unpause', 'type': 'event'}
      ];
}

class WCTOPETHContract implements SmartContract {
  @override
  String get name => 'WCT-OP';

  // https://optimistic.etherscan.io/token/0xef4461891dfb3ac8572ccf7c794664a8dd927945#code
  @override
  String get contractAddress => '0xeF4461891DfB3AC8572cCf7C794664A8DD927945';

  @override
  List<Map<String, dynamic>> get contractABI => [
        {'inputs': [], 'stateMutability': 'nonpayable', 'type': 'constructor'},
        {'inputs': [], 'name': 'CheckpointUnorderedInsertion', 'type': 'error'},
        {'inputs': [], 'name': 'ECDSAInvalidSignature', 'type': 'error'},
        {
          'inputs': [
            {'internalType': 'uint256', 'name': 'length', 'type': 'uint256'}
          ],
          'name': 'ECDSAInvalidSignatureLength',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
          ],
          'name': 'ECDSAInvalidSignatureS',
          'type': 'error'
        },
        {
          'inputs': [
            {
              'internalType': 'uint256',
              'name': 'increasedSupply',
              'type': 'uint256'
            },
            {'internalType': 'uint256', 'name': 'cap', 'type': 'uint256'}
          ],
          'name': 'ERC20ExceededSafeSupply',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'allowance', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'needed', 'type': 'uint256'}
          ],
          'name': 'ERC20InsufficientAllowance',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'sender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'balance', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'needed', 'type': 'uint256'}
          ],
          'name': 'ERC20InsufficientBalance',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'approver', 'type': 'address'}
          ],
          'name': 'ERC20InvalidApprover',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'receiver', 'type': 'address'}
          ],
          'name': 'ERC20InvalidReceiver',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'sender', 'type': 'address'}
          ],
          'name': 'ERC20InvalidSender',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'}
          ],
          'name': 'ERC20InvalidSpender',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
          ],
          'name': 'ERC2612ExpiredSignature',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'signer', 'type': 'address'},
            {'internalType': 'address', 'name': 'owner', 'type': 'address'}
          ],
          'name': 'ERC2612InvalidSigner',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'uint256', 'name': 'timepoint', 'type': 'uint256'},
            {'internalType': 'uint48', 'name': 'clock', 'type': 'uint48'}
          ],
          'name': 'ERC5805FutureLookup',
          'type': 'error'
        },
        {'inputs': [], 'name': 'ERC6372InconsistentClock', 'type': 'error'},
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'},
            {
              'internalType': 'uint256',
              'name': 'currentNonce',
              'type': 'uint256'
            }
          ],
          'name': 'InvalidAccountNonce',
          'type': 'error'
        },
        {'inputs': [], 'name': 'InvalidInitialization', 'type': 'error'},
        {'inputs': [], 'name': 'NotInitializing', 'type': 'error'},
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'}
          ],
          'name': 'OwnableInvalidOwner',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'}
          ],
          'name': 'OwnableUnauthorizedAccount',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'uint8', 'name': 'bits', 'type': 'uint8'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'SafeCastOverflowedUintDowncast',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'uint256', 'name': 'expiry', 'type': 'uint256'}
          ],
          'name': 'VotesExpiredSignature',
          'type': 'error'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'owner',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'spender',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Approval',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'delegator',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'fromDelegate',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'toDelegate',
              'type': 'address'
            }
          ],
          'name': 'DelegateChanged',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'delegate',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'previousVotes',
              'type': 'uint256'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'newVotes',
              'type': 'uint256'
            }
          ],
          'name': 'DelegateVotesChanged',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [],
          'name': 'EIP712DomainChanged',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': false,
              'internalType': 'uint64',
              'name': 'version',
              'type': 'uint64'
            }
          ],
          'name': 'Initialized',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'previousOwner',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'newOwner',
              'type': 'address'
            }
          ],
          'name': 'OwnershipTransferred',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'from',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'to',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Transfer',
          'type': 'event'
        },
        {
          'inputs': [],
          'name': 'CLOCK_MODE',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'pure',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'DOMAIN_SEPARATOR',
          'outputs': [
            {'internalType': 'bytes32', 'name': '', 'type': 'bytes32'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'}
          ],
          'name': 'allowance',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'approve',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'}
          ],
          'name': 'balanceOf',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'burn',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'burnFrom',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'},
            {'internalType': 'uint32', 'name': 'pos', 'type': 'uint32'}
          ],
          'name': 'checkpoints',
          'outputs': [
            {
              'components': [
                {'internalType': 'uint48', 'name': '_key', 'type': 'uint48'},
                {'internalType': 'uint208', 'name': '_value', 'type': 'uint208'}
              ],
              'internalType': 'struct Checkpoints.Checkpoint208',
              'name': '',
              'type': 'tuple'
            }
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'clock',
          'outputs': [
            {'internalType': 'uint48', 'name': '', 'type': 'uint48'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'decimals',
          'outputs': [
            {'internalType': 'uint8', 'name': '', 'type': 'uint8'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'delegatee', 'type': 'address'}
          ],
          'name': 'delegate',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'delegatee', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'nonce', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'expiry', 'type': 'uint256'},
            {'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
            {'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
            {'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
          ],
          'name': 'delegateBySig',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'}
          ],
          'name': 'delegates',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'eip712Domain',
          'outputs': [
            {'internalType': 'bytes1', 'name': 'fields', 'type': 'bytes1'},
            {'internalType': 'string', 'name': 'name', 'type': 'string'},
            {'internalType': 'string', 'name': 'version', 'type': 'string'},
            {'internalType': 'uint256', 'name': 'chainId', 'type': 'uint256'},
            {
              'internalType': 'address',
              'name': 'verifyingContract',
              'type': 'address'
            },
            {'internalType': 'bytes32', 'name': 'salt', 'type': 'bytes32'},
            {
              'internalType': 'uint256[]',
              'name': 'extensions',
              'type': 'uint256[]'
            }
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'uint256', 'name': 'timepoint', 'type': 'uint256'}
          ],
          'name': 'getPastTotalSupply',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'timepoint', 'type': 'uint256'}
          ],
          'name': 'getPastVotes',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'}
          ],
          'name': 'getVotes',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {
              'components': [
                {
                  'internalType': 'address',
                  'name': 'initialOwner',
                  'type': 'address'
                }
              ],
              'internalType': 'struct WCT.Init',
              'name': 'init',
              'type': 'tuple'
            }
          ],
          'name': 'initialize',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
          ],
          'name': 'mint',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'name',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'nonceOwner', 'type': 'address'}
          ],
          'name': 'nonces',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'}
          ],
          'name': 'numCheckpoints',
          'outputs': [
            {'internalType': 'uint32', 'name': '', 'type': 'uint32'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'owner',
          'outputs': [
            {'internalType': 'address', 'name': '', 'type': 'address'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            {'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
            {'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
            {'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
          ],
          'name': 'permit',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'renounceOwnership',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'symbol',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'totalSupply',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'transfer',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'from', 'type': 'address'},
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'transferFrom',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'newOwner', 'type': 'address'}
          ],
          'name': 'transferOwnership',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        }
      ];
}

/// Represents the Wrapped Sonic smart contract deployed on the Sonic Blaze Testnet.
/// This contract provides functionality for interacting with the Wrapped Sonic token.
class WrappedSonicContract implements SmartContract {
  @override
  String get name => 'Wrapped Sonic';

  @override
  String get contractAddress => '0x039e2fB66102314Ce7b64Ce5Ce3E5183bc94aD38';

  @override
  List<Map<String, dynamic>> get contractABI => [
        {'inputs': [], 'stateMutability': 'nonpayable', 'type': 'constructor'},
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'allowance', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'needed', 'type': 'uint256'}
          ],
          'name': 'ERC20InsufficientAllowance',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'sender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'balance', 'type': 'uint256'},
            {'internalType': 'uint256', 'name': 'needed', 'type': 'uint256'}
          ],
          'name': 'ERC20InsufficientBalance',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'approver', 'type': 'address'}
          ],
          'name': 'ERC20InvalidApprover',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'receiver', 'type': 'address'}
          ],
          'name': 'ERC20InvalidReceiver',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'sender', 'type': 'address'}
          ],
          'name': 'ERC20InvalidSender',
          'type': 'error'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'}
          ],
          'name': 'ERC20InvalidSpender',
          'type': 'error'
        },
        {'inputs': [], 'name': 'ERC20InvalidZeroDeposit', 'type': 'error'},
        {
          'inputs': [
            {'internalType': 'address', 'name': 'recipient', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'ERC20WithdrawFailed',
          'type': 'error'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'owner',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'spender',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Approval',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'account',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Deposit',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'from',
              'type': 'address'
            },
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'to',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Transfer',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'internalType': 'address',
              'name': 'account',
              'type': 'address'
            },
            {
              'indexed': false,
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }
          ],
          'name': 'Withdrawal',
          'type': 'event'
        },
        {'stateMutability': 'payable', 'type': 'fallback'},
        {
          'inputs': [
            {'internalType': 'address', 'name': 'owner', 'type': 'address'},
            {'internalType': 'address', 'name': 'spender', 'type': 'address'}
          ],
          'name': 'allowance',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'spender', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'approve',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'}
          ],
          'name': 'balanceOf',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'decimals',
          'outputs': [
            {'internalType': 'uint8', 'name': '', 'type': 'uint8'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'deposit',
          'outputs': [],
          'stateMutability': 'payable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'}
          ],
          'name': 'depositFor',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'payable',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'name',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'symbol',
          'outputs': [
            {'internalType': 'string', 'name': '', 'type': 'string'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [],
          'name': 'totalSupply',
          'outputs': [
            {'internalType': 'uint256', 'name': '', 'type': 'uint256'}
          ],
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'transfer',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'from', 'type': 'address'},
            {'internalType': 'address', 'name': 'to', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'transferFrom',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'withdraw',
          'outputs': [],
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [
            {'internalType': 'address', 'name': 'account', 'type': 'address'},
            {'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
          ],
          'name': 'withdrawTo',
          'outputs': [
            {'internalType': 'bool', 'name': '', 'type': 'bool'}
          ],
          'stateMutability': 'nonpayable',
          'type': 'function'
        }
      ];
}
