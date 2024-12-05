mod frb_generated; /* AUTO INJECTED BY flutter_rust_bridge. This line may not be accurate, and you can change it according to your needs. */
use alloy::primitives::{Bytes, U256, U64};
use alloy::providers::Provider;
use alloy::{network::Ethereum, providers::ReqwestProvider};

use flutter_rust_bridge::frb;

use relay_rpc::domain::ProjectId;
use serde::{Deserialize, Serialize};
use std::time::Duration;

use yttrium::chain_abstraction::api::route::RouteResponse;
use yttrium::chain_abstraction::api::status::{
    StatusResponse, StatusResponseCompleted,
};
use yttrium::chain_abstraction::api::Transaction as CATransaction;
use yttrium::chain_abstraction::client::Client;
use yttrium::config::Config;
use yttrium::transaction::send::safe_test::{
    Address, OwnerSignature as YOwnerSignature, PrimitiveSignature,
};
use yttrium::{
    account_client::{AccountClient as YAccountClient, SignerType},
    private_key_service::PrivateKeyService,
    sign_service::address_from_string,
    transaction::Transaction as YTransaction,
};

#[frb]
#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Transaction {
    pub to: String,
    pub value: String,
    pub data: String,
}

#[frb]
#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct InitTransaction {
    pub from: Address,
    pub to: Address,
    pub value: U256,
    pub gas: U64,
    pub gas_price: U256,
    pub data: Bytes,
    pub nonce: U64,
    pub max_fee_per_gas: U256,
    pub max_priority_fee_per_gas: U256,
    pub chain_id: String,
}

#[frb]
#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct PreparedSendTransaction {
    pub hash: String,
    pub do_send_transaction_params: String,
}

#[frb]
#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct OwnerSignature {
    pub owner: String,
    pub signature: String,
}

#[frb]
#[derive(Debug, thiserror::Error)]
pub enum Error {
    #[error("General {0}")]
    General(String),
}

#[frb]
#[derive(Clone, Debug)]
pub struct Eip1559Estimation {
    pub max_fee_per_gas: String,
    pub max_priority_fee_per_gas: String,
}

#[frb]
pub struct ChainAbstractionClient {
    pub project_id: String,
    client: Client,
}

#[frb]
impl ChainAbstractionClient {
    // #[frb(constructor)]
    pub fn new(project_id: String) -> Self {
        let client = Client::new(ProjectId::from(project_id.clone()));
        Self { project_id, client }
    }
    
    #[frb]
    pub async fn route(
        &self,
        transaction: InitTransaction,
    ) -> Result<RouteResponse, Error> {
        let ca_transaction = CATransaction::from(transaction);
        self.client
            .route(ca_transaction)
            .await
            .map_err(|e| Error::General(e.to_string()))
    }

    #[frb]
    pub async fn status(
        &self,
        orchestration_id: String,
    ) -> Result<StatusResponse, Error> {
        self.client
            .status(orchestration_id)
            .await
            .map_err(|e| Error::General(e.to_string()))
    }

    #[frb]
    pub async fn wait_for_success_with_timeout(
        &self,
        orchestration_id: String,
        check_in: u64,
        timeout: u64,
    ) -> Result<StatusResponseCompleted, Error> {
        self.client
            .wait_for_success_with_timeout(
                orchestration_id,
                Duration::from_secs(check_in),
                Duration::from_secs(timeout),
            )
            .await
            .map_err(|e| Error::General(e.to_string()))
    }

    #[frb]
    pub async fn estimate_fees(
        &self,
        chain_id: String,
    ) -> Result<Eip1559Estimation, Error> {
        let url = format!(
            "https://rpc.walletconnect.com/v1?chainId={chain_id}&projectId={}",
            self.project_id
        )
        .parse()
        .expect("Invalid RPC URL");
        let provider = ReqwestProvider::<Ethereum>::new_http(url);
        // Ensure async execution
        provider
            .estimate_eip1559_fees(None)
            .await
            .map_err(|e| Error::General(e.to_string()))
            .map(|fees| Eip1559Estimation {
                max_fee_per_gas: fees.max_fee_per_gas.to_string(),
                max_priority_fee_per_gas: fees
                    .max_priority_fee_per_gas
                    .to_string(),
            })
    }
}

#[frb]
pub struct AccountClientConfig {
    pub owner_address: String,
    pub chain_id: u64,
    pub config: Config,
    pub signer_type: String,
    pub safe: bool,
    pub private_key: String,
}

#[frb]
pub struct AccountClient {
    pub owner_address: String,
    pub chain_id: u64,
    account_client: YAccountClient,
}

#[frb]
impl AccountClient {
    // #[frb(constructor)]
    pub fn new(config: AccountClientConfig) -> Self {
        let owner_address = config.owner_address.clone();
        let signer_type = config.signer_type.clone();
        let signer = SignerType::from(signer_type).unwrap();
        let account_client = match signer {
            SignerType::PrivateKey => {
                let private_key_fn =
                    Box::new(move || Ok(config.private_key.clone()));
                let owner = address_from_string(&owner_address).unwrap();
                let service = PrivateKeyService::new(private_key_fn, owner);
                YAccountClient::new_with_private_key_service(
                    config.owner_address.clone(),
                    config.chain_id,
                    config.config,
                    service,
                    config.safe,
                )
            }
            SignerType::Native => todo!(),
        };

        Self {
            owner_address: config.owner_address.clone(),
            chain_id: config.chain_id,
            account_client,
        }
    }

    pub fn get_chain_id(&self) -> u64 {
        self.chain_id
    }

    // Async method for fetching address
    #[frb]
    pub async fn get_address(&self) -> Result<String, Error> {
        self.account_client
            .get_address()
            .await
            .map_err(|e| Error::General(e.to_string()))
    }

    #[frb]
    pub async fn send_transactions(
        &self,
        transactions: Vec<Transaction>,
    ) -> Result<String, Error> {
        let ytransactions: Vec<YTransaction> =
            transactions.into_iter().map(YTransaction::from).collect();

        Ok(self
            .account_client
            .send_transactions(ytransactions)
            .await
            .map_err(|e| Error::General(e.to_string()))?
            .to_string())
    }

    #[frb]
    pub async fn prepare_send_transactions(
        &self,
        transactions: Vec<Transaction>,
    ) -> Result<PreparedSendTransaction, Error> {
        let ytransactions: Vec<YTransaction> =
            transactions.into_iter().map(YTransaction::from).collect();

        let prepared_send_transaction = self
            .account_client
            .prepare_send_transactions(ytransactions)
            .await
            .map_err(|e| Error::General(e.to_string()))?;

        Ok(PreparedSendTransaction {
            hash: prepared_send_transaction.hash.to_string(),
            do_send_transaction_params: serde_json::to_string(
                &prepared_send_transaction.do_send_transaction_params,
            )
            .map_err(|e| Error::General(e.to_string()))?,
        })
    }
    
    #[frb]
    pub async fn do_send_transactions(
        &self,
        signatures: Vec<OwnerSignature>,
        do_send_transaction_params: String,
    ) -> Result<String, Error> {
        let mut signatures2: Vec<YOwnerSignature> =
            Vec::with_capacity(signatures.len());

        for signature in signatures {
            signatures2.push(YOwnerSignature {
                owner: signature
                    .owner
                    .parse::<Address>()
                    .map_err(|e| Error::General(e.to_string()))?,
                signature: signature
                    .signature
                    .parse::<PrimitiveSignature>()
                    .map_err(|e| Error::General(e.to_string()))?,
            });
        }

        Ok(self
            .account_client
            .do_send_transactions(
                signatures2,
                serde_json::from_str(&do_send_transaction_params)
                    .map_err(|e| Error::General(e.to_string()))?,
            )
            .await
            .map_err(|e| Error::General(e.to_string()))?
            .to_string())
    }

    pub fn sign_message_with_mnemonic(
        &self,
        message: String,
        mnemonic: String,
    ) -> Result<String, Error> {
        self.account_client
            .sign_message_with_mnemonic(message, mnemonic)
            .map_err(|e| Error::General(e.to_string()))
    }

    #[frb]
    pub async fn wait_for_user_operation_receipt(
        &self,
        user_operation_hash: String,
    ) -> Result<String, Error> {
        self.account_client
            .wait_for_user_operation_receipt(
                user_operation_hash.parse().map_err(|e| {
                    Error::General(format!("Parsing user_operation_hash: {e}"))
                })?,
            )
            .await
            .iter()
            .map(serde_json::to_string)
            .collect::<Result<String, serde_json::Error>>()
            .map_err(|e| Error::General(e.to_string()))
    }
}

#[frb]
impl From<Transaction> for YTransaction {
    fn from(transaction: Transaction) -> Self {
        YTransaction::new_from_strings(
            transaction.to,
            transaction.value,
            transaction.data,
        )
        .unwrap()
    }
}

#[frb]
impl From<InitTransaction> for CATransaction {
    fn from(source: InitTransaction) -> Self {
        CATransaction {
            from: source.from,
            to: source.to,
            value: source.value,
            gas: source.gas,
            gas_price: source.gas_price,
            data: source.data,
            nonce: source.nonce,
            max_fee_per_gas: source.max_fee_per_gas,
            max_priority_fee_per_gas: source.max_priority_fee_per_gas,
            chain_id: source.chain_id,
        }
    }
}

#[cfg(test)]
mod tests {
    use alloy::{
        network::Ethereum,
        providers::{Provider, ReqwestProvider},
    };

    #[tokio::test]
    #[ignore = "run manually"]
    async fn estimate_fees() {
        let chain_id = "eip155:42161";
        let project_id = std::env::var("REOWN_PROJECT_ID").unwrap();
        let url = format!(
            "https://rpc.walletconnect.com/v1?chainId={chain_id}&projectId={project_id}")
        .parse()
        .expect("Invalid RPC URL");
        let provider = ReqwestProvider::<Ethereum>::new_http(url);

        let estimate = provider.estimate_eip1559_fees(None).await.unwrap();

        println!("estimate: {estimate:?}");
    }
}
