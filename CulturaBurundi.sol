// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaBurundi
 * @dev Registro de micro-proteinas lacustres y procesamiento de granos.
 * Serie: Sabores de Africa (26/54)
 */
contract CulturaBurundi {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 densidadProteica;   // Contenido estimado de proteina (1-100)
        uint256 gradoMolienda;      // Granulometria del cereal (1-10)
        bool esPescadoLago;         // Validador de origen Tanganica
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Ndagala Frit (Ingenieria de la micro-proteina)
        registrarPlato(
            "Ndagala", 
            "Peces pequenos del Lago Tanganica, aceite, cebolla, tomate.",
            "Secado solar previo o fritura rapida para mantener la integridad de los acidos grasos y minerales.",
            85, 
            0, 
            true
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _densidad, 
        uint256 _molienda,
        bool _lago
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_densidad <= 100, "Densidad proteica invalida");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            densidadProteica: _densidad,
            gradoMolienda: _molienda,
            esPescadoLago: _lago,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 densidad,
        uint256 molienda,
        bool lago,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.densidadProteica, p.gradoMolienda, p.esPescadoLago, p.likes);
    }
}
