// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title SnowScore — ScoreRegistry
/// @notice Permite a cualquier usuario anclar su SnowScore en Avalanche.
///         El score numérico va en el evento (indexable). El hash keccak256
///         del payload completo (JSON estandarizado) va en el campo `hash` para
///         que terceros puedan re-validar la integridad de los datos.
contract ScoreRegistry {
    /// @notice Emitido cuando un usuario ancla su score.
    /// @param user dirección que firma (msg.sender)
    /// @param score 0–100
    /// @param grade A-Z / +/- codificado en un byte (ej: "A-" = 0x412D)
    /// @param hash keccak256 del payload completo (JSON estandarizado)
    /// @param confidence 0–100 (entero, representa porcentaje *100)
    event ScoreAnchored(
        address indexed user,
        uint8 score,
        bytes2 grade,
        bytes32 hash,
        uint16 confidence,
        uint256 timestamp
    );

    /// @notice Último score anclado por cada usuario.
    struct AnchoredScore {
        uint8 score;
        bytes2 grade;
        bytes32 hash;
        uint16 confidence;
        uint256 timestamp;
        uint64 nonce;
    }

    mapping(address => AnchoredScore) public lastScore;
    mapping(address => uint64) public anchorCount;

    /// @notice Total de anclajes en el registro (público, agregable).
    uint256 public totalAnchors;

    /// @param score 0–100
    /// @param grade 2 bytes (ej: 0x412D = "A-")
    /// @param hash keccak256(payload)
    /// @param confidence 0–100
    function anchorScore(uint8 score, bytes2 grade, bytes32 hash, uint16 confidence) external {
        require(score <= 100, "score>100");
        require(confidence <= 100, "conf>100");

        uint64 newNonce = anchorCount[msg.sender] + 1;
        anchorCount[msg.sender] = newNonce;
        totalAnchors++;

        lastScore[msg.sender] = AnchoredScore({
            score: score,
            grade: grade,
            hash: hash,
            confidence: confidence,
            timestamp: block.timestamp,
            nonce: newNonce
        });

        emit ScoreAnchored(msg.sender, score, grade, hash, confidence, block.timestamp);
    }

    /// @notice Helper para consultar el último score de un usuario en una sola call.
    function getLastScore(address user)
        external
        view
        returns (uint8, bytes2, bytes32, uint16, uint256, uint64)
    {
        AnchoredScore memory s = lastScore[user];
        return (s.score, s.grade, s.hash, s.confidence, s.timestamp, s.nonce);
    }
}
