var gm = require( 'gm' );
var _ = require('lodash');
var async = require('async');
var fs = require('fs');



var processRawImages = function(){
	var frameNames = _.times(config.rows * config.cols, function(n){
		return config.name + (n + 1);
	});
	//console.log('\nproccessing', frameNames);

	async.map(frameNames, processImage, function(){
		createSpriteSheet(config.name, config.rows, config.cols);
	})
}

var processImage = function(frameName, callback){
	var correctShadow = function(frameName, cb){
		var tempName = './' + config.name + '/temp/' + frameName + '.png'
		//extract shadow only
		gm('./' + config.name + '/raw/' + frameName + '_noshadow.png')
			.command("composite")
			.in("-compose", "Out")
			.in('./' + config.name + '/raw/' + frameName + ".png")
			.write(tempName, function(err){
				if(err) console.log('err', err);
				//Correct color of shadow
				gm(tempName)
					.threshold('100%')
					.operator('Opacity', 'Max', '50%')
					.write(tempName, function(err){
						if(err) console.log('err', err);

						//Merge the corrected shadow and raw noshadow together
						gm()
							.command("composite")
							.in("-compose", "Over")
							.in('./' + config.name + '/raw/' + frameName + '_noshadow.png')
							.in(tempName)
							.write(tempName, function(err){
								if(err) console.log('err', err);
								console.log('Finished ', frameName);
								cb()
							});
					});
			});
	}

	var cropResize = function(frameName, cb){
		gm('./' + config.name + '/temp/' + frameName + '.png')
			.crop(config.crop.width, config.crop.height, config.crop.x, config.crop.y)
			.resize(config.resize.width, config.resize.height)
			.write('./' + config.name + '/temp/' + frameName + '.png', function(err){
				if(err) console.log('err', err);
				cb()
			});
	}

	return correctShadow(frameName, function(){
		cropResize(frameName, function(){
			callback();
		});
	});
}

var createSpriteSheet = function(imgName, row, col){
	var cmd = gm()
		.command('montage')
		.in('-tile')
		.in(col + 'x' + row)

		.in('-geometry')
		.in('x' + config.resize.height)

		.in("-background")
		.in('none')

	_.times(col*row, function(num){
		cmd = cmd.in('./' + config.name + '/temp/' + imgName + (num + 1) + '.png')
	})
	cmd.write('./' + config.name + '/animation.png', function(err){
		if(err) return console.log(err);
		console.log('Created sprite sheet');
	});
}

/////////////////////////////


var config = {};
if(process.argv.length > 2){
	console.log();
	config = JSON.parse(fs.readFileSync(__dirname + process.argv[2]));
}else{
	console.log('You must pass in a sheet config json');
}

console.log('config', config);

//processRawImages();


createSpriteSheet(config.name, config.rows, config.cols);
