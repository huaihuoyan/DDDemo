(function ($) {

    $.List = function () {

        var _list = new Array();
        //外部为数组赋值
        this.GetDataSource = function (arr) {
            if (IsArrayType(arr)) {
                _list = arr;
            } else {
                console.log("指定元素非数组类型，赋值失败！");
            }
        };
        //添加一个元素
        this.Add = function (arg) {
            if (arg) {
                _list.push(arg);
            } else {
                console.log("参数错误，添加元素失败！");
            }
            return _list;
        };
        //删除指定索引的元素
        this.RemoveAt = function (index) {

            if (IsArrayIndex(index) && index < _list.length) {
                var i;
                var arr = new Array();
                for (i = 0; i < _list.length; i++) {
                    if (i != index) {
                        arr.push(_list[i]);
                    }
                }
                _list = arr;
                return _list;
            }
            else {
                console.log("未获取到设置对象的实例，删除元素失败！");
            }
        };
        //按照指定的分割符显示出所有元素
        this.Split = function (arg) {
            arg = arg || ",";
            var i, res;
            res = "";
            if (_list.length > 0) {
                for (i = 0; i < _list.length; i++) {
                    res += _list[i].toString() + arg;
                }

                return res.substr(0, (res.length - arg.toString().length));
            } else {
                return "";
            }
        };
        //外部调用直接返回当前数组实力
        this.ToArray = function () {
            return _list;
        };
        //设置指定索引处的值为指定值
        this.Update = function (index, value) {
            if (IsArrayIndex(index) && index < _list.length) {
                _list[index] = value;
            }
            return _list;
        };
        //清空所有元素
        this.RemoveAll = function () {
            _list.splice(0, _list.length);
            return _list;
        };

        //根据传入的值获取第一次出现在数组中的下标

        this.IndexOf = function (value) {
            if (value) {
                var i;
                for (i = 0; i < _list.length; i++) {
                    if (_list[i] == value) {
                        return i;
                    }
                }
            }
            return -1;
        };
        //获取数组长度

        this.Size = function () {
            return _list.length;
        };

        //移除数组中重复的项

        this.RemoveRepeat = function () {
            _list.sort();
            var rs = [];
            var cr = false;
            for (var i = 0; i < _list.length; i++) {
                if (!cr)
                    cr = _list[i];
                else if (cr == _list[i])
                    rs[rs.length] = i;
                else
                    cr = _list[i];
            }

            for (var i = rs.length - 1; i >= 0; i--)
                this.RemoveAt(rs[i]);

            return _list;
        };

        //对数字数组元素排序，参数：0升序1降序

        this.SortNumber = function (f) {
            if (!f) f = 0;
            if (f == 1) return _list.sort(function (a, b) { return b - a; });
            return _list.sort(function (a, b) { return a - b; });
        };


        //私有方法
        //判断正确的数组下标
        function IsArrayIndex(index) {
            var reg = /^\d+$/;
            if (reg.test(index))
                return true;
            else
                return false;
        }
        //判断当前对象是否为数组对象
        function IsArrayType(arr) {
            if (typeof arr == 'object' && typeof arr.length == 'number')
                return true;
            else
                return false;
        }

    }; //结束List的构造方法


})(jQuery);