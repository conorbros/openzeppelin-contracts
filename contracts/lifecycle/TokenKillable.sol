pragma solidity ^0.4.8;


import "../ownership/Ownable.sol";
import "../token/ERC20Basic.sol";

/// @title TokenKillable:
/// @author Remco Bloemen <remco@2π.com>
///.Base contract that can be killed by owner. All funds in contract including
/// listed tokens will be sent to the owner
contract TokenKillable is Ownable {

  /// @notice Terminate contract and refund to owner
  /// @param  tokens List of addresses of ERC20 or ERC20Basic token contracts to
  //          refund
  /// @notice The called token contracts could try to re-enter this contract.
  //          Only supply token contracts you
  function kill(address[] tokens) onlyOwner {

    // Transfer tokens to owner
    for(uint i = 0; i < tokens.length; i++) {
      ERC20Basic token = ERC20Basic(tokens[i]);
      uint256 balance = token.balanceOf(this);
      token.transfer(owner, balance);
    }

    // Transfer Eth to owner and terminate contract
    selfdestruct(owner);
  }
}