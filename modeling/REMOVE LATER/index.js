

/*
var imageName = 'windturbine'
var crop = {
	x : 477,
	y : 197,
	width : 529,
	height : 405
};
var resize = {
	width : null,
	height : 250
}

var numFrames = 24
var numCols = 6;
*/

var config = {
	name : 'windturbine',
	rows : 2,
	cols : 12,
	crop : {
		x : 477,
		y : 197,
		width : 529,
		height : 405
	},
	resize : {
		width : null,
		height : 250
	}
}



var fixImage = function(num, callback){
	var result = gm('./' + imageName + (num) + '.png')
		.crop(crop.width, crop.height, crop.x, crop.y)
		.resize(resize.width, resize.height)
		.write('./result/i' + num + '.png', callback);
}

var createRow = function(i, offset, callback){
	var row = gm();
	_.times(numCols, function(n){
		row.append('./result/i' + (n + 1 + offset) + '.png', true);
	});
	row.write('./result/row' + i + '.png', callback);
};


var createGrid = function(){
	var grid = gm();
	async.series(_.times(numFrames / numCols, function(num){
		return function(callback){
			console.log('row', num);
			createRow(num + 1, num * numCols, function(err){
				grid.append('./result/row' + (num + 1) + '.png');
				callback();
			})
		}


	}), function(err){
		console.log('done', err);
		grid.write('./result/grid.png', function(err){

			console.log('DONE', err);
		})
	})
}



/////////////////////////////////


/*
console.log('working');
async.each(_.times(24, function(i){return i+1}), fixImage, function(err){
	createGrid();
})
*/



/*

var opacity = 0.5;
gm("./windturbine24.png")
	//.operator('All', 'Assign', '0%')
	//.out("-operator", "Opacity", "Assign", "90%")
	//.out("-matte")
	.region(400, 100, 632, 493)
	//.operator('All', 'Assign', '0%')
	//.fuzz('80%')
	//.fill("#000000")
	.fill("rgba(0,0,0,0.5")
	//.fill('red')
	.opaque('#828282')
	//.operator('Black', 'Assign', '50%')

	//.fill("#00000000")



	//.operator('Opacity', 'Assign', '50%')
	.write('result.png', function(err){
		if(err) return console.log(err);
		return console.log('done');
	});
*/



var shadowAttempt1 = function(){
	gm("./windturbine24.png")

		.threshold('100%')
		.operator('Opacity', 'Max', '50%')

		//.operator('All', 'Assign', '50%')
		//.in("./windturbine24-noshadow.png")


		//.command("composite")
		//.mosaic()

		//.operator('Opacity', 'Assign', '50%')

		.write('result.png', function(){
			gm('./windturbine24-noshadow.png')
				.operator('Opacity', 'Threshold', '0')
				.write('result2.png', function(){
					gm()
						.command("composite")
						.in("-compose", "Over")
						.in('./result2.png')
						.in("result.png")
					.write('result3.png', function(){
						console.log('done');
					})
				})

		})

		/*
		.write('result.png', function(err){
			if(err) return console.log(err);
			return console.log('done');
		});
	*/
}

var baseImage='windturbine-big'

var makeIntoShadow = function(filename, cb){
	gm(filename)
		.threshold('100%')
		.operator('Opacity', 'Max', '50%')
		.write('result-shadow.png', function(){
			console.log('made shadow');
			cb()
		});
}

var compositeShadow = function(base, shadow){
	gm()
		.command("composite")
		.in("-compose", "Over")

		.in(baseImage + '-noshadow.png')
		.in("result-shadow.png")

		.write('./result-final.png', function(){
			console.log('really done');
		});
}

var shadowAttempt2 = function(){

	//gm(baseImage + ".png")
	gm(baseImage + '-noshadow.png')
		.command("composite")
		.in("-compose", "Out")
		//.in(baseImage + '-noshadow.png')
		.in(baseImage + ".png")
		.write('only-shadow.png', function(){
			console.log('done');
			makeIntoShadow('only-shadow.png', function(){
				compositeShadow(baseImage + '-noshadow.png')
			})
		});

}
