pragma solidity ^0.8.17;

import "./Roles.sol";

contract FpoRole {

  using Roles for Roles.Role;

  event FpoAdded(address indexed account);
  event FpoRemoved(address indexed account);
  
  // Define a struct 'Fpos' by inheriting from 'Roles' library, struct Role
  Roles.Role private fpos;

  // In the constructor make the address that deploys this contract the 1st Fpo
  constructor() public {
    _addFpo(msg.sender);
  }

  // Checks to see if msg.sender has the appropriate role
  modifier onlyFpo() {
    require(isFpo(msg.sender));
    _;
  }

  function isFpo(address account) public view returns (bool) {
    return fpos.has(account);
  }

  function addFpo(address account) public onlyFpo {
    _addFpo(account);
  }

  function renounceFpo() public {
    _removeFpo(msg.sender);
  }

  function _addFpo(address account) internal {
    fpos.add(account);
    emit FpoAdded(account);
  }

  function _removeFpo(address account) internal {
    fpos.remove(account);
    emit FpoRemoved(account);
  }
}