// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract FPOProduceTokens is ERC1155 {
    address public governance;
    uint256 public FPOProduceCount;
    
    modifier onlyGovernance() {
        require(msg.sender == governance, "only governance can call this");
    
        _;
    }

    constructor(address governance_) public ERC1155("") {
        governance = governance_;
        FPOProduceCount = 0;
    }
    
    function addNewProduceItem(uint256 initialSupply) external onlyGovernance {
        FPOProduceCount++;
        uint256 FPOProduceClassId = FPOProduceCount;

        _mint(msg.sender, FPOProduceClassId, initialSupply, "");        
    }
}