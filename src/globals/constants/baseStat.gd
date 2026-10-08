class_name BaseStat
extends RefCounted


class PLAYER:
	const HEALTH: int = 6
	const SPEED: float = 5.0
	const DAMAGE: int = 2
	const JUMP_VELOCITY: float = 7.0
	const FRICTION: float = 10.0
	const SLIDE_FRICTION: float = 1.0
	const SLIDE_SPEED: float = 8.0
	const MAX_SLIDE_SPEED: float = 100.0
	const SLOPE_ACCELERATION: float = 20.0
	const STEER_INFLUENCE: float = 1.0
	const TURNING_SPEED: float = 7.0


class ENEMY:
	class ANT:
		const HEALTH: int = 3
		const SPEED: float = 7.0
		const DAMAGE: int = 2
		const FRICTION: float = 25.0
	
	class BETTLE:
		const HEALTH: int = 3
		const SPEED: float = 9.0
		const DAMAGE: int = 1
		const FRICTION: float = 25.0
	class ROLY_POLY:
		const HEALTH: int = 4
		const SPEED: float = 5.0
		const DAMAGE: int = 4
		const FRICTION: float = 25.0
