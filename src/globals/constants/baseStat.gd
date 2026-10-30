class_name BaseStat
extends RefCounted


class PLAYER:
	const HEALTH: int = 6
	const SPEED: float = 4.5
	const DAMAGE: int = 2
	const JUMP_VELOCITY: float = 7.0
	const FRICTION: float = 10.0
	const SLIDE_FRICTION: float = 0.5
	const SLIDE_SPEED: float = 12.0
	const MAX_SLIDE_SPEED: float = 100.0
	const SLOPE_ACCELERATION: float = 15.0
	const STEER_INFLUENCE: float = 2.0
	const TURNING_SPEED: float = 7.0


class ENEMY:
	class ANT:
		const HEALTH: int = 3
		const SPEED: float = 7.0
		const DAMAGE: int = 2
		const FRICTION: float = 25.0

	class BEETLE:
		const HEALTH: int = 5
		const SPEED: float = 9.0
		const DAMAGE: int = 1
		const FRICTION: float = 25.0

	class ROLY_POLY:
		const HEALTH: int = 4
		const SPEED: float = 5.0
		const DAMAGE: int = 4
		const FRICTION: float = 25.0
