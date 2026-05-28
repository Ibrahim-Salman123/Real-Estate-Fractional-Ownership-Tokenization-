# PropertyToken Smart Contract

A decentralized real estate fractionalization and rental yield distribution smart contract built on Ethereum using the ERC20 standard and OpenZeppelin libraries.

---

## 📌 Overview

The **PropertyToken** smart contract enables real-world real estate assets to be tokenized into fractional ERC20 tokens. Investors can purchase these tokens to own a fraction of the property. The contract owner (Property Manager/Issuer) can deposit and distribute accumulated rental income in native Ether, allowing token holders to claim their share of the rental yield securely.

> **⚠️ Disclaimer:** This smart contract is a technological simulation of real-estate fractionalization. It does not constitute financial or legal advice. Deploying asset-backed tokens may be subject to securities regulations in various jurisdictions.

---

## 🛠 Features

* **Fractional Ownership:** Leverages OpenZeppelin's secure ERC20 implementation to split property equity into tradable tokens.
* **Owner-Controlled Administration:** Uses the `Ownable` pattern to restrict rental deposits and administrative configurations to the contract owner.
* **Batch Rental Allocations:** Implements an efficient batch-processing function (`depositRentForInvestors`) to manually assign rental payouts to verified investor addresses.
* **Pull-Payment Yield Distribution:** Token holders pull their earned revenue manually via `claimRent`, protecting the contract from common gas limit or reentrancy vectors.

---

## 📄 Smart Contract Architecture

### Inherited Modules
* `ERC20`: Provides standard fungible token behaviors (transfer, balance tracking).
* `Ownable`: Restricts access to sensitive administration tasks.

### State Variables
* `totalPropertyValuation`: The total financial valuation assigned to the underlying property asset.
* `monthlyRentYield`: Storage tracking metric for the property's estimated monthly rental income.
* `unclaimedRent`: A public mapping (`investorAddress => remainingWei`) tracking outstanding rental revenue available for withdrawal.

---

## ⚙️ Core Functions

#### 1. `constructor(string memory _name, string memory _symbol, uint256 _totalSupply, uint256 _valuation)`
Initializes the ERC20 token identity, mints the total fractional token supply to the deployer, sets the initial asset valuation, and designates the deployer as the contract owner.

#### 2. `depositRentForInvestors(address[] calldata investors, uint256[] calldata amounts)`
* **Permission:** Only `owner` (Requires Ether deposit)
* **Description:** Accepts an array of investor addresses along with a corresponding array of distribution amounts (in Wei) to batch-update the `unclaimedRent` ledger.

#### 3. `claimRent()`
* **Permission:** Public (Invoked by investors)
* **Description:** Validates if the caller has any outstanding balance inside `unclaimedRent`. It resets the investor's pending mapping state to zero before executing a safe native transfer of the Ether payload.

---

## 🔔 Events

* `RentDistributed(uint256 amount)`: Emitted when rental funds are successfully locked into the distribution lifecycle.
* `RentClaimed(address indexed investor, uint256 amount)`: Emitted instantly when an investor executes a withdrawal.

---

## 🚀 Tech Stack & Setup

* **Language:** Solidity `^0.8.20`
* **Dependencies:** `@openzeppelin/contracts`

### Local Compilation & Setup

1. Open **Remix IDE**.
2. Install dependencies or use npm imports directly.
3. Create `PropertyToken.sol` and paste the codebase.
4. Compile with version `0.8.20`.
5. Provide deployment arguments (e.g., `"Apartment Token"`, `"APT"`, `1000000`, `500000000000000000000`) and deploy.

---

## ⚖️ License

This project is licensed under the **MIT License**.
