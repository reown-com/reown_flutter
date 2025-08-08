import YttriumWrapper

extension Eip1559Estimation {
    func toJson() -> [String: Any] {
        return [
            "maxFeePerGas": self.maxFeePerGas,
            "maxPriorityFeePerGas": self.maxPriorityFeePerGas
        ]
    }
}

extension SolanaTransaction {
    func toJson() -> [String: Any] {
        return [
            "chainId": chainId,
            "from": from,
            "transaction": transaction
        ]
    }
}

extension SolanaTxnDetails {
    func toJson() -> [String: Any] {
        return [
            "transaction": transaction.toJson(),
            "transactionHashToSign": transactionHashToSign
        ]
    }
}

extension Route {
    func toJson() -> [[String: Any]] {
        switch self {
        case .eip155(let txns):
            return (txns as [TxnDetails]).map { $0.toJson() } // list of TxnDetails
        case .solana(let txns):
            return (txns as [SolanaTxnDetails]).map { $0.toJson() } // list of SolanaTxnDetails
        }
    }
}

extension UiFields {
    func toJson() -> [String: Any] {
        let route = route.map { $0.toJson() }.first
        return [
            "routeResponse": routeResponse.toJson(),
            "route": route ?? [],
            "localRouteTotal": localRouteTotal.toJson(),
            "bridge": bridge.map { $0.toJson() },
            "localBridgeTotal": localBridgeTotal.toJson(),
            "initial": initial.toJson(),
            "localTotal": localTotal.toJson()
        ]
    }
}

extension Transactions {
    func toJson() -> [[String: Any]] {
        switch self {
        case .eip155(let txns):
            return (txns as [Transaction]).map { $0.toJson() } // list of Transaction
        case .solana(let txns):
            return (txns as [SolanaTransaction]).map { $0.toJson() } // list of SolanaTransaction
        }
    }
}

extension PrepareResponseAvailable {
    func toJson() -> [String: Any] {
        let transactions = transactions.map { $0.toJson() }.first // list of `Transactions`
        return [
            "orchestrationId": orchestrationId,
            "initialTransaction": initialTransaction.toJson(),
            "transactions": transactions ?? [],
            "metadata": metadata.toJson()
        ]
    }
}

extension Transaction {
    func toJson() -> [String: Any] {
        return [
            "chainId": chainId,
            "from": from,
            "to": to,
            "value": value,
            "input": input,
            "gasLimit": gasLimit,
            "nonce": nonce
        ]
    }
}

extension Metadata {
    func toJson() -> [String: Any] {
        return [
            "fundingFrom": fundingFrom.map { $0.toJson() },
            "initialTransaction": initialTransaction.toJson(),
            "checkIn": String(checkIn)
        ]
    }
}

extension FundingMetadata {
    func toJson() -> [String: Any] {
        return [
            "chainId": chainId,
            "tokenContract": tokenContract,
            "symbol": symbol,
            "amount": amount,
            "bridgingFee": bridgingFee,
            "decimals": decimals
        ]
    }
}

extension InitialTransactionMetadata {
    func toJson() -> [String: Any] {
        return [
            "transferTo": transferTo,
            "amount": amount,
            "tokenContract": tokenContract,
            "symbol": symbol,
            "decimals": decimals
        ]
    }
}

extension TxnDetails {
    func toJson() -> [String: Any] {
        return [
            "transaction": transaction.toJson(),
            "transactionHashToSign": transactionHashToSign,
            "fee": fee.toJson()
        ]
    }
}

extension FeeEstimatedTransaction {
    func toJson() -> [String: Any] {
        return [
            "chainId": chainId,
            "from": from,
            "to": to,
            "value": value,
            "input": input,
            "gasLimit": gasLimit,
            "nonce": nonce,
            "maxFeePerGas": maxFeePerGas,
            "maxPriorityFeePerGas": maxPriorityFeePerGas
        ]
    }
}

extension TransactionFee {
    func toJson() -> [String: Any] {
        return [
            "fee": fee.toJson(),
            "localFee": localFee.toJson()
        ]
    }
}

extension PrepareResponseNotRequired {
    func toJson() -> [String: Any] {
        return [
            "initialTransaction": initialTransaction.toJson(),
            "transactions": transactions.map { $0.toJson() }
        ]
    }
}

extension PrepareResponseError {
    func toJson() -> [String: Any] {
        return [
            "error": error.toJson(), // BridgingError
            "reason": reason,
        ]
    }
}

extension BridgingError {
    func toJson() -> String {
        switch self {
        case .assetNotSupported:
            return "assetNotSupported"
        case .noRoutesAvailable:
            return "noRoutesAvailable"
        case .insufficientFunds:
            return "insufficientFunds"
        case .insufficientGasFunds:
            return "insufficientGasFunds"
        default:
            return "unknown"
        }
    }
}

extension Amount {
    func toJson() -> [String: Any] {
        return [
            "symbol": symbol,
            "amount": amount,
            "unit": unit,
            "formatted": formatted,
            "formattedAlt": formattedAlt
        ]
    }
}

extension ExecuteDetails {
    func toJson() -> [String: Any] {
        return [
            "initialTxnReceipt": initialTxnReceipt,
            "initialTxnHash": initialTxnHash
        ]
    }
}

extension Currency {
    static func fromString(value: String) -> Currency {
        switch value.lowercased() {
        case "usd": return .usd
        case "eur": return .eur
        case "gbp": return .gbp
        case "aud": return .aud
        case "cad": return .cad
        case "inr": return .inr
        case "jpy": return .jpy
        case "btc": return .btc
        case "eth": return .eth
        default: return .usd
        }
    }
}

