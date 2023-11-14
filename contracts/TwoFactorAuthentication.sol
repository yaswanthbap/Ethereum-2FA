// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TwoFactorAuthentication {
    struct UserData {
        address userAddress;
        string email;
        bytes32 passwordHash;
        bytes32 salt;
        string[] authenticationTokens;
    }

    UserData[] public users;

    receive() external payable {
        // This function will be called when the contract receives ether
        // You can implement custom logic here if needed
    }

    function register(string memory email, string memory password) public payable {
        require(bytes(email).length > 0, "Email cannot be empty");
        require(bytes(password).length > 0, "Password cannot be empty");

        // Generate a random salt
        bytes32 salt = keccak256(abi.encodePacked(block.timestamp, msg.sender));
        bytes32 passwordHash = keccak256(abi.encodePacked(password, salt));

        // Check if the user is already registered
        for (uint256 i = 0; i < users.length; i++) {
            require(
                keccak256(abi.encodePacked(users[i].email)) != keccak256(abi.encodePacked(email)),
                "User with this email already registered"
            );
        }

        UserData memory userData;
        userData.userAddress = msg.sender;
        userData.email = email;
        userData.passwordHash = passwordHash;
        userData.salt = salt;
        userData.authenticationTokens = new string[](0);
        users.push(userData);
    }

        function login(string memory email, string memory password) public payable returns (bool) {
        for (uint256 i = 0; i < users.length; i++) {
            if (keccak256(abi.encodePacked(users[i].email)) == keccak256(abi.encodePacked(email))) {
                bytes32 providedPasswordHash = keccak256(abi.encodePacked(password, users[i].salt));
                if (providedPasswordHash == users[i].passwordHash) {
                    return true;
                }
            }
        }
        return false;
    }


    function setAuthenticationTokens(address userAddress, string[] memory tokens) public payable {
        require(tokens.length <= 5, "Exceeds the maximum number of tokens (5)");

        for (uint256 i = 0; i < users.length; i++) {
            if (users[i].userAddress == userAddress) {
                users[i].authenticationTokens = tokens;
                return;
            }
        }
    }

    function checkAuthenticationToken(address userAddress, string memory token) public payable returns (bool) {
    for (uint256 i = 0; i < users.length; i++) {
        if (users[i].userAddress == userAddress) {
            string[] storage storedTokens = users[i].authenticationTokens;
            bytes32 tokenHash = keccak256(abi.encodePacked(token));  // Hash the provided token

            for (uint256 j = 0; j < storedTokens.length; j++) {
                if (keccak256(abi.encodePacked(storedTokens[j])) == tokenHash) {
                    return true;
                }
            }
            return false;
        }
    }
    return false;
}


}
