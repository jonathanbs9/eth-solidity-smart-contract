pragma solidity 0.4.24;

contract GuessNumber {
    address private player; 
    uint  prize;            
    uint randomNumber;      

    // Nuevas variables
    uint private constant gameCost = 200000000000000000;  // 0.2 ETH
    address private owner;
    bool private playing = false;

    // Desplegamos msg al jugador una vez que hagamos la interfaz de usuario.
    event Number(string, uint randNumber, string, uint guessedNumber, string,  uint prize);
    
    // Constructor
    constructor() public payable {
        require(msg.value >= 10000000000000000 , "El contrato se debe lanzar con al menos 0.1 ETH.");
        owner = msg.sender;

    }
    
    // Función adivina
    function guess(uint guessNumber) public payable {
        require(msg.value == 200000000000000000, "El costo del juego es de 0.2 ETH. ");
        require(!playing, "Actualmente hay otro jugador, espere un momento para poder jugar ... ");
        
        uint randNumber = uint(keccak256(abi.encodePacked(now, msg.sender))) %10 + 1;

        if (guessNumber  == randNumber) {
            player = msg.sender;
            prize = 1000000000000000000; 
        }
        emit Number("El numero que salio en el sorteo fue: ",randNumber," Elegiste el : ",guessNumber,"Ganaste: ", prize);
    }
}
