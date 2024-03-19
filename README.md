Smart contracts custom methods

 
mint 

Parameters: 

uint256 amount: The number of tokens to mint. 

bytes32 _hash: Hash of the message to be signed. 

uint8 _v: Recovery byte of the signature. 

bytes32 _r: First 32 bytes of the signature. 

bytes32 _s: Second 32 bytes of the signature. 

uint256 deadline: Deadline after which the signature is not valid. 

Access Control: Can only be called by the contract owner. 


Functionality: 

Validates the mint amount, hash, and signature. 

Increments ownerNounce. 

Mints the specified amount of tokens to the sender's address. 




burn 

Parameters: 

uint256 amount: The number of tokens to burn. 

Access Control: Can be called by any token holder. 
 
