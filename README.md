// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title Aegis Sentinel V2 (The God Protocol)
 * @author Aegis Security Team
 * @notice An autonomous, predictive asset protection layer for the Polkadot ecosystem.
 * @dev Integrates Somnia Reactivity and AI-driven threat heuristics for proactive fund rescue.
 */

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @dev Interface for Somnia's Reactivity Engine.
 * Enables the contract to respond to external on-chain events autonomously.
 */
interface ISomniaEventHandler {
    function onEvent(bytes32 eventType, bytes calldata eventData) external;
}

contract AegisSentinelV2 is Ownable, ReentrancyGuard {
    
    // --- State Variables ---

    address public recoveryVault;      // Secure destination for rescued assets
    address public trustedAIOracle;    // Authorized source for threat intelligence
    uint256 public threatThreshold;    // Sensitivity level (0-100%) for AI alerts

    // --- Events ---

    event SentinelActivated(address indexed vault, uint256 timestamp, uint256 probability);
    event RecoveryVaultUpdated(address indexed newVault);
    event ThreatThresholdUpdated(uint256 newThreshold);
    event FundsRescued(uint256 amount);

    /**
     * @notice Initializes the Sentinel with a safe vault and trusted intelligence source.
     * @param _initialVault The cold-storage address for asset migration.
     * @param _aiOracle The address authorized to trigger threat alerts.
     */
    constructor(address _initialVault, address _aiOracle) Ownable(msg.sender) {
        require(_initialVault != address(0), "Aegis: Invalid vault address");
        require(_aiOracle != address(0), "Aegis: Invalid oracle address");

        recoveryVault = _initialVault;
        trustedAIOracle = _aiOracle;
        threatThreshold = 85; // Default threshold for high-confidence threats
    }

    // --- Somnia Reactivity Logic ---

    /**
     * @notice Automated event handler triggered by the Somnia Network.
     * @dev Listens for 'AI_ANOMALY_DETECTED' events to execute a proactive rescue.
     * @param eventType The keccak256 hash of the event identifier.
     * @param eventData Encoded data containing the threat probability.
     */
    function onEvent(bytes32 eventType, bytes calldata eventData) external {
        // Access Control: Only the designated AI Oracle can trigger a rescue
        require(msg.sender == trustedAIOracle, "Aegis: Unauthorized threat source");

        // Logic Gate: Check if the event matches the AI Anomaly signature
        if (eventType == keccak256("AI_ANOMALY_DETECTED")) {
            uint256 probability = abi.decode(eventData, (uint256));
            
            // Critical Execution: Trigger rescue if threat probability exceeds threshold
            if (probability >= threatThreshold) {
                _executeRescue(probability);
            }
        }
    }

    // --- Internal Rescue Mechanism ---

    /**
     * @dev Moves all contract-held assets to the recovery vault in a single atomic transaction.
     * @param _probability The confidence score of the detected threat.
     */
    function _executeRescue(uint256 _probability) internal nonReentrant {
        uint256 balance = address(this).balance;
        
        emit SentinelActivated(recoveryVault, block.timestamp, _probability);
        
        if (balance > 0) {
            (bool success, ) = payable(recoveryVault).call{value: balance}("");
            require(success, "Aegis: Migration failed");
            emit FundsRescued(balance);
        }
    }

    // --- Administrative Functions ---

    /**
     * @notice Updates the destination for rescued assets.
     * @param _newVault New cold-storage address.
     */
    function setRecoveryVault(address _newVault) external onlyOwner {
        require(_newVault != address(0), "Aegis: Invalid address");
        recoveryVault = _newVault;
        emit RecoveryVaultUpdated(_newVault);
    }

    /**
     * @notice Adjusts the sensitivity of the AI trigger.
     * @param _newThreshold The new percentage (0-100).
     */
    function setThreatThreshold(uint256 _newThreshold) external onlyOwner {
        require(_newThreshold <= 100, "Aegis: Threshold out of bounds");
        threatThreshold = _newThreshold;
        emit ThreatThresholdUpdated(_newThreshold);
    }

    /**
     * @notice Allows the contract to receive native assets (PAS/DOT).
     */
    receive() external payable {}
}
