///@function approach(value1, value2, amount)
///@param{real}
///@description Função que funciona semelhante ao lerp, porém não diminui ao chegar no valor determinado
function approach(_val1, _val2, _amount){
	if (_val1 < _val2) {
		_val1 += _amount
		if (_val1 > _val2) {
			return _val2;
		}
	}else{
		_val1 += _amount;
		if (_val1 < _val2){
			return _val2;	
		}
	}
	return _val1
}

function timer(_sec){
	static _timer = 0;
	
	var _time = delta_time / 1000000;
	
	_timer += _time;
	
	if(_timer >= _sec){
		_timer = 0;
		return true;
	};
};