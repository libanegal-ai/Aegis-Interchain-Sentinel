// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title Aegis Sentinel V2 (The God Protocol)
 * @author Aegis Security Protocol
 * @notice An autonomous, predictive asset protection layer for the Polkadot ecosystem.
 * @dev This contract leverages Somnia Reactivity and AI-driven heuristics to execute 
 * proactive fund migration (Autonomous Rescue Trigger) before exploits settle.
 */

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @dev Interface for the Somnia Reactivity Engine.
 * Allows the contract to react to cross-chain events and AI signals autonomously.
 */
interface ISomniaEventHandler {
    function onEvent(bytes32 eventType, bytes calldata eventData) external;
}

contract AegisSentinelV2 is Ownable, ReentrancyGuard {
    
    // --- State Variables ---

    address public recoveryVault;      // The secure destination for asset migration
    address public trustedAIOracle;    // Authorized intelligence source for threat detection
    uint256 public threatThreshold;    // The confidence level required to trigger rescue (0-100)

    // --- Events ---

    event SentinelActivated(address indexed recoveryVault, uint256 timestamp, uint256 threatProbability);
    event RecoveryVaultUpdated(address indexed newVault);
    event ThreatThresholdUpdated(uint256 newThreshold);
    event AssetsSuccessfullySecured(uint256 amountMigrated);

    /**
     * @notice Initializes the Sentinel with security parameters.
     * @param _initialVault The cold-storage address for emergency migrations.
     * @param _aiOracle The address of the AI engine providing threat signals.
     */
    constructor(address _initialVault, address _aiOracle) Ownable(msg.sender) {
        require(_initialVault != address(0), "Aegis: Vault cannot be zero address");
        require(_aiOracle != address(0), "Aegis: Oracle cannot be zero address");

        recoveryVault = _initialVault;
        trustedAIOracle = _aiOracle;
        threatThreshold = 85; // Institutional default: 85% probability
    }

    // --- Somnia Reactivity Core ---

    /**
     * @notice Automated event handler triggered by the Somnia Network.
     * @dev Listens for 'AI_ANOMALY_DETECTED' hashes to initiate the rescue logic.
     * @param eventType The keccak256 hash representing the anomaly type.
     * @param eventData Encoded data containing the threat probability score.
     */
    function onEvent(bytes32 eventType, bytes calldata eventData) external {
        // Security Check: Ensure the event is coming from the authorized AI Oracle
        require(msg.sender == trustedAIOracle, "Aegis: Unauthorized event source");

        // Identity Check: Validate the event type against the Anomaly Signature
        if (eventType == keccak256("AI_ANOMALY_DETECTED")) {
            uint256 probability = abi.decode(eventData, (uint256));
            
            // Execution Check: Initiate rescue if probability meets the God Protocol threshold
            if (probability >= threatThreshold) {
                _executeRescue(probability);
            }
        }
    }

    // --- Autonomous Rescue Mechanism ---

    /**
     * @dev Internal function to migrate all contract-held assets to the recovery vault.
     * @param _probability The confidence score of the detected exploit.
     */
    function _executeRescue(uint256 _probability) internal nonReentrant {
        uint256 balance = address(this).balance;
        
        emit SentinelActivated(recoveryVault, block.timestamp, _probability);
        
        if (balance > 0) {
            // Using low-level call for gas efficiency and compatibility with modern EVM standards
            (bool success, ) = payable(recoveryVault).call{value: balance}("");
            require(success, "Aegis: Emergency migration failed");
            
            emit AssetsSuccessfullySecured(balance);
        }
    }

    // --- Governance & Calibration ---

    /**
     * @notice Updates the secure destination for asset migration.
     * @param _newVault The new recovery address.
     */
    function setRecoveryVault(address _newVault) external onlyOwner {
        require(_newVault != address(0), "Aegis: Invalid vault address");
        recoveryVault = _newVault;
        emit RecoveryVaultUpdated(_newVault);
    }

    /**
     * @notice Adjusts the sensitivity of the AI trigger.
     * @param _newThreshold The new probability threshold (0-100).
     */
    function setThreatThreshold(uint256 _newThreshold) external onlyOwner {
        require(_newThreshold <= 100, "Aegis: Threshold exceeds 100%");
        threatThreshold = _newThreshold;
        emit ThreatThresholdUpdated(_newThreshold);
    }

    /**
     * @dev Fallback to accept native assets (PAS/DOT).
     */
    receive() external payable {}
}

