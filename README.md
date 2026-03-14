// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title AegisPolkadotSentinel
 * @dev Autonomous security layer to protect assets on Polkadot Hub.
 */
contract AegisPolkadotSentinel {
    address public owner;
    address public recoveryVault;

    event SentinelActivated(address indexed vault, uint256 timestamp);
    event VaultUpdated(address indexed newVault);

    constructor(address _initialVault) {
        owner = msg.sender;
        recoveryVault = _initialVault;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Aegis: Not authorized");
        _;
    }

    /**
     * @dev Triggers an emergency asset rescue to the recovery vault.
     */
    function triggerRescue() external onlyOwner {
        emit SentinelActivated(recoveryVault, block.timestamp);
    }

    /**
     * @dev Updates the secure recovery vault address.
     * @param _newVault The address of the new secure vault.
     */
    function updateVault(address _newVault) external onlyOwner {
        require(_newVault != address(0), "Aegis: Invalid vault address");
        recoveryVault = _newVault;
        emit VaultUpdated(_newVault);
    }
}
