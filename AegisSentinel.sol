// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@somnia-chain/reactivity-contracts/contracts/SomniaEventHandler.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract AegisSentinel is SomniaEventHandler, Ownable, ReentrancyGuard {
    address public recoveryVault;
    address public trustedEventSource;

    event SentinelActivated(address indexed target, uint256 timestamp);

    constructor(address _eventManager, address _trustedSource, address _vault) 
        SomniaEventHandler(_eventManager) 
        Ownable(msg.sender) 
    {
        trustedEventSource = _trustedSource;
        recoveryVault = _vault;
    }

    function _onEvent(bytes32 eventType, bytes calldata eventData) internal override {
        require(msg.sender == trustedEventSource, "Aegis: Unauthorized source");
        if (eventType == keccak256("PROTOCOL_EXPLOIT_ALERT")) {
            _executeRescue();
        }
    }

    function _executeRescue() internal nonReentrant {
        emit SentinelActivated(recoveryVault, block.timestamp);
    }
}
