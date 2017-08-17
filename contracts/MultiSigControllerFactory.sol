pragma solidity ^0.4.15;

import "lib/Proxy.sol";
import "lib/PrivateServiceRegistry.sol";
import "MultiSigController.sol";


contract MultiSigControllerFactory is PrivateServiceRegistry {
    function createProxy(address[] _members, uint256 _required, uint256 _dailyLimit) public returns (address) {
      Proxy proxy = new Proxy();
      proxy.transfer(new MultiSigController(proxy, _members, _required, _dailyLimit));
      register(proxy);
      return address(proxy);
    }

    function createController(address _proxy, address[] _members, uint256 _required, uint256 _dailyLimit) public returns (address service) {
      service = address(new MultiSigController(_proxy, _members, _required, _dailyLimit));
      register(service);
    }
}
