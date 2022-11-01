	
	let walls = [];
	//let ray;
	let particle;
	
	let xoff = 0;
	let yoff = 10000;
	
	const sceneW = 400;
	const sceneH = 400;
	let sliderFOV;
	
	function setup() {
		createCanvas((sceneW * 2), sceneH);
		
		for(let i = 0; i < 5; i++) {
			let x1 = random(sceneW);
			let y1 = random(sceneH);
			let x2 = random(sceneW);
			let y2 = random(sceneH);
			
			walls[ i ] = new Boundary(x1, y1, x2, y2);
		}
		
		// sketch boundaries
		walls.push( new Boundary(0, 0, sceneW, 0) );
		walls.push( new Boundary(sceneW, 0, sceneW, sceneH) );
		walls.push( new Boundary(sceneW, sceneH, 0, sceneH) );
		walls.push( new Boundary(0, sceneH, 0, 0) );
		
		// particle
		particle = new Particle((sceneW / 2), (sceneH / 2));
		
		// fov input
		sliderFOV = createSlider(0, 360, 45);
		sliderFOV.input(changeFOV);
	}
	
	function changeFOV() {
		const fov = sliderFOV.value();
		
		particle.updateFOV(fov);
	}
	
	function draw() {
		// movement
		if(keyIsDown(LEFT_ARROW)) {
			particle.rotate(-0.05);
		} else if(keyIsDown(RIGHT_ARROW)) {
			particle.rotate(0.05);
		}
		
		if(keyIsDown(UP_ARROW)) {
			particle.move(1);
		} else if(keyIsDown(DOWN_ARROW)) {
			particle.move(-1);
		}
		
		
		// drawing
		background(0);
		
		for(let wall of walls) {
			wall.show();
		}
		
		//particle.update(mouseX, mouseY);
		//particle.update((noise(xoff) * sceneW), (noise(yoff) * sceneH));
		
		particle.show();
		
		//const distProjPlane = sceneW / 2.0 / tan(particle.fov);   // projection plane is required for fisheye fix
		const scene = particle.look(walls);
		
		const w = sceneW / scene.length;
		
		push();
		translate(sceneW, 0);
		
		for(let i = 0; i < scene.length; i++) {
			noStroke();
			const sq = scene[ i ] * scene[ i ];
			const wSq = sceneW * sceneW;
			
			const b = map(sq, 0, wSq, 255, 0);
			const h = map(scene[ i ], 0, sceneW, sceneH, 0);
			//const h = (sceneW / scene[ i ]) * distProjPlane;   // fisheye fix
			
			fill(b);
			rectMode(CENTER);
			rect((i * w + w / 2), sceneH / 2, w + 1, h);
		}
		pop();
		
		xoff += 0.01;
		yoff += 0.01;
	}
	