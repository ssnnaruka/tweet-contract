pragma solidity ^0.4.15;

contract EtherMsg1 {
    
    event Message(address indexed _sender, address indexed _receiver, uint256 _time, string message);
    event PublicKeyUpdated(address indexed _sender, string _key, string _keytype);
    
    struct message
    {
        address from;
        string  text;
    }
    
    struct public_key_struct
    {
        string key;
        string key_type;
    }
    
    mapping (address => uint256) public last_msg_index;
    mapping (address => mapping (uint256 => message)) public messages;
    mapping (address => public_key_struct) public keys;
    
    function sendMessage(address _to, string _text)
    {
        messages[_to][last_msg_index[_to]].from = msg.sender;
        messages[_to][last_msg_index[_to]].text = _text;
        last_msg_index[_to]++;
        Message(msg.sender, _to, now, _text);
    }
    
    function lastIndex(address _owner) constant returns (uint256)
    {
        return last_msg_index[_owner];
    }
    
    function getLastMessage(address _who) constant returns (address, string)
    {
        require(last_msg_index[_who] > 0);
        return (messages[_who][last_msg_index[_who] - 1].from, messages[_who][last_msg_index[_who] - 1].text);
    }
    
    function getMessageByIndex(address _who, uint256 _index) constant returns (address, string)
    {
        return (messages[_who][_index].from, messages[_who][_index].text);
    }
    
    function getPublicKey(address _who) constant returns (string _key, string _key_type)
    {
        return (keys[_who].key, keys[_who].key_type);
    }
    
    function setPublicKey(string _key, string _type)
    {
        keys[msg.sender].key = _key;
        keys[msg.sender].key_type = _type;
        PublicKeyUpdated(msg.sender, _key, _type);
    }
}