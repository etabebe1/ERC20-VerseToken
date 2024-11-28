// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {VerseToken} from "../src/VerseToken.sol";
import {Script} from "forge-std/Script.sol";

contract DeployVerseToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function run() external {
        vm.startBroadcast();
        new VerseToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
    }
}
