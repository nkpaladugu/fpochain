pragma solidity ^0.8.17;

import "./Roles.sol";

contract FarmerRole {
  using Roles for Roles.Role;

  event FarmerAdded(address indexed account);
  event FarmerRemoved(address indexed account);

  // Define a struct 'farmers' by inheriting from 'Roles' library, struct Role
  Roles.Role private farmers;

  // In the constructor make the address that deploys this contract the 1st farmer
  constructor() public {
    _addFarmer(msg.sender);
  }

  // Checks to see if msg.sender has the appropriate role
  modifier onlyFarmer() {
    require(isFarmer(msg.sender));
    _;
  }

  function isFarmer(address account) public view returns (bool) {
    return farmers.has(account);
  }

  function addFarmer(address account) public onlyFarmer {
    _addFarmer(account);
  }

  function renounceFarmer() public {
    _removeFarmer(msg.sender);
  }

  function _addFarmer(address account) internal {
    farmers.add(account);
    emit FarmerAdded(account);
  }

  function _removeFarmer(address account) internal {
    farmers.remove(account);
    emit FarmerRemoved(account);
  }
}