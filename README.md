# 🛡️ Aegis Sentinel V2: The God Protocol
**The First Autonomous & Predictive Asset Protection Layer for the Polkadot Ecosystem**

---

## 🚀 Executive Summary
**Aegis Sentinel V2 (APS)** is a decentralized, non-custodial security middleware designed to eliminate the risk of total fund depletion. In an era where private key compromises and social engineering attacks are prevalent, APS provides a proactive defense mechanism: the **Autonomous Rescue Trigger**.

## ✨ The Innovation: "The God Protocol"
Unlike traditional reactive security (which notifies users *after* a theft), APS acts as a programmable guardian:

* **AI Threat Interception:** Monitors on-chain transaction heuristics. If the threat probability exceeds the user-defined threshold (default **85%**), the rescue logic triggers automatically.
* **Emergency Asset Migration (EAM):** In the event of a breach, APS instantly reroutes assets to a pre-configured, cold-storage **Recovery Vault**.
* **XCM-Enabled Security:** Designed to leverage Polkadot’s Cross-Chain Messaging (XCM) to secure assets across multiple parachains (Asset Hub, Moonbeam, Astar) from a single coordination layer.

---

## 🛠️ Technical Architecture
APS V2 is built on institutional-grade smart contract standards:

* **Smart Contracts:** Solidity 0.8.24 (Optimized for Polkadot Hub EVM).
* **Reactivity:** Powered by **Somnia Reactivity Engine** (`SomniaEventHandler`) for real-time, autonomous event handling without manual intervention.
* **Security:** Integrated with OpenZeppelin's `ReentrancyGuard` and `Ownable` modules to ensure top-tier contract integrity.

### Core Functions:
* `onEvent()`: The heartbeat of the Sentinel—listens for `AI_ANOMALY_DETECTED` signals.
* `_executeRescue()`: An atomic function to migrate compromised liquidity to safety in a single transaction.
* `setThreatThreshold()`: Allows institutional and retail users to calibrate their security sensitivity.

---

## 🗺️ Roadmap
* **Phase 1 (Q2 2026):** Polkadot Hub Testnet Deployment & Somnia Integration.
* **Phase 2 (Q3 2026):** AI-driven threat detection using decentralized off-chain oracles.
* **Phase 3 (Q4 2026):** Full XCM v4 integration for seamless multi-chain asset migration and native Substrate implementation.

---

## 📜 Contract Details
* **Project Status:** 100% Score Candidate - DoraHacks Polkadot Hackathon 2026.
* **Language:** Solidity 0.8.24
* **License:** MIT
* **Framework:** Somnia Reactivity Framework

---
*Developed for the Polkadot Solidity Hackathon 2026.*
