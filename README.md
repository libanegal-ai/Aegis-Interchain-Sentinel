import React, { useState, useEffect } from 'react';
import { ethers } from 'ethers';

// Professional UI Components using Tailwind-style logic
const App = () => {
  const [account, setAccount] = useState(null);
  const [isRescuing, setIsRescuing] = useState(false);
  const [status, setStatus] = useState("Secured");

  // Logic to connect wallet
  const connectWallet = async () => {
    if (window.ethereum) {
      const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
      setAccount(accounts[0]);
    } else {
      alert("Fadlan rakibo MetaMask ama Polkadot Wallet!");
    }
  };

  const handleRescue = async () => {
    setIsRescuing(true);
    setStatus("Initiating Rescue...");
    
    // Simulate Blockchain Transaction for Demo
    setTimeout(() => {
      setIsRescuing(false);
      setStatus("Assets Migrated to Vault");
      alert("SUCCESS: All assets have been moved to your secure Recovery Vault!");
    }, 3000);
  };

  return (
    <div className="min-h-screen bg-slate-950 text-slate-100 font-sans p-8">
      {/* Header Section */}
      <header className="max-w-6xl mx-auto flex justify-between items-center border-b border-slate-800 pb-6">
        <div className="flex items-center gap-3">
          <div className="bg-pink-600 p-2 rounded-lg shadow-lg shadow-pink-500/20">
            <span className="text-2xl">🛡️</span>
          </div>
          <h1 className="text-2xl font-bold tracking-tight">AEGIS <span className="text-pink-500">SENTINEL</span></h1>
        </div>
        
        {!account ? (
          <button onClick={connectWallet} className="bg-pink-600 hover:bg-pink-700 px-6 py-2 rounded-full font-bold transition-all transform hover:scale-105">
            Connect Wallet
          </button>
        ) : (
          <div className="flex items-center gap-4 bg-slate-900 px-4 py-2 rounded-full border border-slate-700">
            <div className="w-2 h-2 bg-green-500 rounded-full animate-pulse"></div>
            <span className="text-sm font-mono text-slate-400">{account.slice(0,6)}...{account.slice(-4)}</span>
          </div>
        )}
      </header>

      {/* Main Dashboard Grid */}
      <main className="max-w-6xl mx-auto mt-12 grid grid-cols-1 md:grid-cols-3 gap-8">
        
        {/* Security Status Card */}
        <div className="bg-slate-900 p-6 rounded-2xl border border-slate-800 shadow-xl">
          <h3 className="text-slate-400 text-sm font-semibold uppercase mb-4">Security Status</h3>
          <div className="flex items-end justify-between">
            <p className={`text-3xl font-bold ${status === "Secured" ? "text-green-400" : "text-yellow-400"}`}>{status}</p>
            <span className="text-4xl">🔒</span>
          </div>
          <p className="text-xs text-slate-500 mt-4 italic">Powered by Somnia Reactivity Layer</p>
        </div>

        {/* Assets Monitored Card */}
        <div className="bg-slate-900 p-6 rounded-2xl border border-slate-800 shadow-xl">
          <h3 className="text-slate-400 text-sm font-semibold uppercase mb-4">Protected Assets</h3>
          <div className="flex items-end justify-between">
            <p className="text-3xl font-bold text-white">4 Tokens</p>
            <span className="text-4xl">💰</span>
          </div>
          <p className="text-xs text-slate-500 mt-4 uppercase tracking-widest font-bold">DOT | USDT | USDC | MOVR</p>
        </div>

        {/* Network Health Card */}
        <div className="bg-slate-900 p-6 rounded-2xl border border-slate-800 shadow-xl">
          <h3 className="text-slate-400 text-sm font-semibold uppercase mb-4">Network Connectivity</h3>
          <div className="flex items-end justify-between">
            <p className="text-3xl font-bold text-pink-500">POLKADOT HUB</p>
            <span className="text-4xl">🌐</span>
          </div>
          <p className="text-xs text-slate-500 mt-4 font-bold">Latency: 12ms (Reactive Speed)</p>
        </div>

        {/* Action Center - Emergency Button */}
        <div className="md:col-span-3 bg-gradient-to-r from-slate-900 to-slate-800 p-10 rounded-3xl border border-pink-500/20 text-center shadow-2xl relative overflow-hidden">
          <div className="relative z-10">
            <h2 className="text-3xl font-bold mb-4 italic text-pink-500">EMERGENCY ACTION CENTER</h2>
            <p className="text-slate-400 mb-8 max-w-xl mx-auto">
              If you detect unauthorized transactions or a private key compromise, trigger the Autonomous Rescue immediately.
            </p>
            
            <button 
              onClick={handleRescue}
              disabled={isRescuing}
              className={`px-12 py-5 rounded-2xl text-xl font-black transition-all transform active:scale-95 shadow-2xl ${
                isRescuing ? "bg-slate-700 cursor-not-allowed" : "bg-red-600 hover:bg-red-500 hover:shadow-red-500/50"
              }`}
            >
              {isRescuing ? "RESCUE IN PROGRESS..." : "🚨 TRIGGER EMERGENCY RESCUE"}
            </button>
          </div>
          {/* Background Glow Effect */}
          <div className="absolute top-0 right-0 w-64 h-64 bg-pink-500/5 blur-[100px] rounded-full"></div>
          <div className="absolute bottom-0 left-0 w-64 h-64 bg-red-500/5 blur-[100px] rounded-full"></div>
        </div>
      </main>

      <footer className="text-center mt-20 text-slate-600 text-sm border-t border-slate-900 pt-8">
        <p>© 2026 Aegis Polkadot Sentinel - Developed for Polkadot Solidity Hackathon</p>
      </footer>
    </div>
  );
};

export default App;

# Aegis Polkadot Sentinel (APS)
### The First Autonomous Asset Protection Layer for the Polkadot Ecosystem

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ecosystem: Polkadot](https://img.shields.io/badge/Ecosystem-Polkadot-E6007A?logo=polkadot)](https://polkadot.network/)

## 🛡️ Executive Summary
Aegis Polkadot Sentinel (APS) is a decentralized, non-custodial security middleware designed to eliminate the threat of total fund depletion. In an era where private key compromises and social engineering attacks are prevalent, APS provides a proactive defense mechanism: the **Autonomous Rescue Trigger**.

## 🚀 The Innovation: Autonomous Rescue Logic
Unlike traditional reactive security (notifying users *after* a theft), APS is a programmable guardian. 
- **Threat Interception:** Monitors on-chain interactions and outbound transaction heuristics.
- **Emergency Asset Migration (EAM):** In the event of a breach, APS instantly reroutes assets to a pre-configured, cold-storage **Recovery Vault**.
- **XCM-Enabled Security:** Designed to leverage Polkadot’s Cross-Chain Messaging (XCM) to secure assets across multiple parachains (Moonbeam, Astar, Asset Hub).

## 🛠 Technical Architecture
APS is built on institutional-grade smart contract standards:
* **Security Protocol:** Solidity 0.8.24 with OpenZeppelin `ReentrancyGuard` and `Ownable` modules.
* **Logic Gate:** Heuristic-based monitoring that triggers asset isolation upon unauthorized signature detection.
* **Interoperability:** Optimized for Substrate-based EVM environments (Moonbeam/Astar).

## 📦 Core Smart Contract
The heart of APS is the `AegisSentinel.sol` contract, featuring:
1. `executeRescue()`: An atomic function to migrate compromised liquidity.
2. `recoveryVault`: A user-defined secure destination.
3. `isSentinelActive`: A programmable toggle for active/passive monitoring states.

## 🗺️ Roadmap
* **Phase 1 (Q2 2026):** Integration with **IdentChain** for Biometric-authorized fund releases.
* **Phase 2 (Q3 2026):** AI-driven threat detection using off-chain oracles.
* **Phase 3 (Q4 2026):** Native Substrate implementation via Ink! Smart Contracts.
