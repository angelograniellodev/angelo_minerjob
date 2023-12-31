var audioPlayer = null;

function httpPost(event, data) {
	const xhr = new XMLHttpRequest(); 
	xhr.open("POST", "https://angelo_minerjob/" + event, true);
	xhr.send(JSON.stringify({ data }));
}

window.addEventListener('message', function(event) {
	if (event.data.type == "showNUIMachine") {
		document.querySelector("body").style.display = 'block';
	}
    if (event.data.transactionType == "playSound") {
        if (audioPlayer != null) {
          audioPlayer.pause();
        }
        audioPlayer = new Howl({src: ["./sounds/" + event.data.transactionFile + ".ogg"]});
        audioPlayer.volume(event.data.transactionVolume);
        audioPlayer.play();
      }
});

const silverBTN = document.getElementById('silver');
const diamondBTN = document.getElementById('diamond');
const emeraldBTN = document.getElementById('emerald');
const rubyBTN = document.getElementById('ruby');

silver.addEventListener('click', function() {
    httpPost("cuttore", "uncut_silver");
    httpPost("nuioff");
    document.querySelector("body").style.display = 'none';
    window.location.reload();
});

diamond.addEventListener('click', function() {
    httpPost("cuttore", "uncut_diamond");
    httpPost("nuioff");
    document.querySelector("body").style.display = 'none';
    window.location.reload();
});

emeraldBTN.addEventListener('click', function() {
    httpPost("cuttore", "uncut_emerald");
    httpPost("nuioff");
    document.querySelector("body").style.display = 'none';
    window.location.reload();
});

rubyBTN.addEventListener('click', function() {
    httpPost("cuttore", "uncut_ruby");
    httpPost("nuioff");
    document.querySelector("body").style.display = 'none';
    window.location.reload();
});

document.onkeydown = function (data) {
	if (data.which == '314' || '27') { 
		document.querySelector("body").style.display = 'none';
		httpPost("nuioff");
	}
};