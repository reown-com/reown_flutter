import YttriumWrapper

extension Eip1559Estimation {
    func toJson() -> [String: Any] {
        return [
            "maxFeePerGas": self.maxFeePerGas,
            "maxPriorityFeePerGas": self.maxPriorityFeePerGas
        ]
    }
}

extension UiFields {
    func toJson() -> [String: Any] {
        return [
            "routeResponse": routeResponse.toJson(),
            "route": route.map { $0.toJson() },
            "localRouteTotal": localRouteTotal.toJson(),
            "bridge": bridge.map { $0.toJson() },
            "localBridgeTotal": localBridgeTotal.toJson(),
            "initial": initial.toJson(),
            "localTotal": localTotal.toJson()
        ]
    }
}

extension PrepareResponseAvailable {
    func toJson() -> [String: Any] {
        return [
            "orchestrationId": orchestrationId,
            "initialTransaction": initialTransaction.toJson(),
            "transactions": transactions.map { $0.toJson() },
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
            "error": error.toJson()
        ]
    }
}

extension BridgingError {
    func toJson() -> [String: Any] {
        switch self {
        case .noRoutesAvailable:
            return ["error": "noRoutesAvailable"]
        case .insufficientFunds:
            return ["error": "insufficientFunds"]
        case .insufficientGasFunds:
            return ["error": "insufficientGasFunds"]
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
