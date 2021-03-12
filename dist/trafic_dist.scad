function vopt(param, def1, def2, def3) = ((param != undef) ? param : ((def1 != undef) ? def1 : ((def2 != undef) ? def2 : def3)));
function vpoint(size, x, y, z) = let(n = (visnum(size) ? size : undef)) [vopt(x, size[0], n, 1), vopt(y, size[1], n, 1), vopt(z, size[2], n, 1)];
function vcenters(center = false, centerx, centery, centerz) = let(center = vopt(center, false)) [vopt(centerx, center), vopt(centery, center), vopt(centerz, center)];
function visdef(param) = !is_undef(param);
function visundef(param) = is_undef(param);
function vislist(param) = (visdef(param) && is_list(param));
function visnum(param) = (visdef(param) && is_num(param));
function velem(list, pos, deflt, end) = let(l = (vislist(list) ? len(list) : 0), e = (visdef(end) ? end : 0), pos = vopt(pos, (l + e))) (visnum(list) ? ((pos == 0) ? list : vopt(deflt, list)) : ((pos < 0) ? vopt(deflt, list[0]) : ((pos >= l) ? vopt(deflt, list[(l - 1)]) : list[pos])));
function vorder(param) = ((visnum(param) || visundef(param)) ? [] : concat([len(param)], vorder(param[0])));
function vlevel(param) = len(vorder(param));
function vrange(nb, start = 0, inc = 1) = [start : inc : (start + (inc * (nb - 1)))];
function vindexes(v, start = 0, end = 0, inc = 1) = let(n = (visnum(v) ? v : len(v))) ((inc > 0) ? let(end = ((end > 0) ? (end - 1) : ((n - 1) + end))) [start : inc : end] : let(m = -inc, nb = ((end > 0) ? (end - 1) : (((n * m) + end) - 1))) [for(i = [0 : (n - 1)]) (for(j = [0 : (m - 1)]) (let(pos = ((i * m) + j)) (if(((pos >= start) && (pos <= nb))) (i))))]);
function vcopy(vs, start = 0, end = 0, inc = 1) = [for(i = vindexes(vs, start, end, inc)) (let(i = (i % len(vs))) ((i < 0) ? vs[(len(vs) + i)] : vs[i]))];
function vabs(v) = (visnum(v) ? abs(v) : [for(i = v) (abs(i))]);
function vsub2(l) = [for(i = vindexes(l, end = -1)) ((l[(i + 1)] - l[i]))];
function vsum2(l) = [for(i = vindexes(l, end = -1)) ((l[i] + l[(i + 1)]))];
function vlinear(i, a, b) = (a + ((b - a) * i));
function vlookup(i, v, n = 1) = let(pos = (((len(v) - 1) * i) / n), vi = floor(pos), t = (pos - vi), start = velem(v, vi), end = velem(v, (vi + 1))) vlinear(t, start, end);
function v2dto3d(pts, z = 0) = [for(pt = pts) ([pt.x, pt.y, z])];
function v3dto2d(pts) = [for(pt = pts) ([pt.x, pt.y])];
function vinverse(l) = let(n = len(l)) [for(i = [(n - 1) : -1 : 0]) (l[i])];
function vopt(param, def1, def2, def3) = ((param != undef) ? param : ((def1 != undef) ? def1 : ((def2 != undef) ? def2 : def3)));
function vpoint(size, x, y, z) = let(n = (visnum(size) ? size : undef)) [vopt(x, size[0], n, 1), vopt(y, size[1], n, 1), vopt(z, size[2], n, 1)];
function vcenters(center = false, centerx, centery, centerz) = let(center = vopt(center, false)) [vopt(centerx, center), vopt(centery, center), vopt(centerz, center)];
function visdef(param) = !is_undef(param);
function visundef(param) = is_undef(param);
function vislist(param) = (visdef(param) && is_list(param));
function visnum(param) = (visdef(param) && is_num(param));
function velem(list, pos, deflt, end) = let(l = (vislist(list) ? len(list) : 0), e = (visdef(end) ? end : 0), pos = vopt(pos, (l + e))) (visnum(list) ? ((pos == 0) ? list : vopt(deflt, list)) : ((pos < 0) ? vopt(deflt, list[0]) : ((pos >= l) ? vopt(deflt, list[(l - 1)]) : list[pos])));
function vorder(param) = ((visnum(param) || visundef(param)) ? [] : concat([len(param)], vorder(param[0])));
function vlevel(param) = len(vorder(param));
function vrange(nb, start = 0, inc = 1) = [start : inc : (start + (inc * (nb - 1)))];
function vindexes(v, start = 0, end = 0, inc = 1) = let(n = (visnum(v) ? v : len(v))) ((inc > 0) ? let(end = ((end > 0) ? (end - 1) : ((n - 1) + end))) [start : inc : end] : let(m = -inc, nb = ((end > 0) ? (end - 1) : (((n * m) + end) - 1))) [for(i = [0 : (n - 1)]) (for(j = [0 : (m - 1)]) (let(pos = ((i * m) + j)) (if(((pos >= start) && (pos <= nb))) (i))))]);
function vcopy(vs, start = 0, end = 0, inc = 1) = [for(i = vindexes(vs, start, end, inc)) (let(i = (i % len(vs))) ((i < 0) ? vs[(len(vs) + i)] : vs[i]))];
function vabs(v) = (visnum(v) ? abs(v) : [for(i = v) (abs(i))]);
function vsub2(l) = [for(i = vindexes(l, end = -1)) ((l[(i + 1)] - l[i]))];
function vsum2(l) = [for(i = vindexes(l, end = -1)) ((l[i] + l[(i + 1)]))];
function vlinear(i, a, b) = (a + ((b - a) * i));
function vlookup(i, v, n = 1) = let(pos = (((len(v) - 1) * i) / n), vi = floor(pos), t = (pos - vi), start = velem(v, vi), end = velem(v, (vi + 1))) vlinear(t, start, end);
function v2dto3d(pts, z = 0) = [for(pt = pts) ([pt.x, pt.y, z])];
function v3dto2d(pts) = [for(pt = pts) ([pt.x, pt.y])];
function vinverse(l) = let(n = len(l)) [for(i = [(n - 1) : -1 : 0]) (l[i])];
function vsq(x) = (x * x);
function vvect(n = 3, v1 = 1, pos = undef, v2 = 0) = ((pos == undef) ? [for(i = vrange(n)) (v1)] : [for(i = vrange(n)) (((i == pos) ? v1 : v2))]);
function vvnull(n) = vvect(n, 0);
function vvunary(n = 3) = vvect(n, 1);
function vvunit(n = 3, pos = 0) = vvect(n, 1, pos, 0);
function vvset(v, e, pos = 0) = (visnum(e) ? [for(i = vindexes(v)) (((i == pos) ? e : v[i]))] : [for(i = vindexes(v)) ((((i >= pos) && (i < (pos + len(e)))) ? e[(i - pos)] : v[i]))]);
function vvget(v, pos = 0) = let(n = len(v), p = (pos % n)) v[((p + n) % n)];
function vsum(v) = (v * vvunary(len(v)));
function vnorm(v) = sqrt((v * v));
function vdistance(a, b) = norm((a - b));
function vdist(a, b) = norm((a - b));
function vdot(a, b) = (a * b);
function vdet(a, b) = ((a.x * b.y) - (a.y * b.x));
function vnormalize(v) = (v / norm(v));
function vrotate2d(a) = [[cos(a), -sin(a)], [sin(a), cos(a)]];
function vmatrix(n = 3, v1 = 1, v2 = 0) = [for(i = vrange(n)) ([for(j = vrange(n)) (((i == j) ? v1 : v2))])];
function vmnull(n = 3) = vmatrix(n, 0, 0);
function vmunary(n = 3) = vmatrix(n, 1, 1);
function vmunit(n = 3) = vmatrix(n, 1, 0);
function vtr(x = 0, y = 0, z = 0) = ((vlevel(x) == 0) ? [[1, 0, 0, x], [0, 1, 0, y], [0, 0, 1, z], [0, 0, 0, 1]] : ((vlevel(x) == 1) ? vtr(x[0], x[1], x[2]) : [for(i = vindexes(x)) (vtr(x[i]))]));
function vtx(x) = vtr(x = x);
function vty(y) = vtr(y = y);
function vtz(z) = vtr(z = z);
function vrx(a) = [[1, 0, 0, 0], [0, cos(a), -sin(a), 0], [0, sin(a), cos(a), 0], [0, 0, 0, 1]];
function vry(a) = [[cos(a), 0, sin(a), 0], [0, 1, 0, 0], [-sin(a), 0, cos(a), 0], [0, 0, 0, 1]];
function vrz(a) = [[cos(a), -sin(a), 0, 0], [sin(a), cos(a), 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]];
function vscale(s = 1, x, y, z) = let(x = vopt(x, s), y = vopt(y, s), z = vopt(z, s)) ((vlevel(s) == 0) ? [[x, 0, 0, 0], [0, y, 0, 0], [0, 0, z, 0], [0, 0, 0, 1]] : ((vlevel(s) == 1) ? vscale(1, s[0], s[1], s[2]) : [for(v = s) (vscale(v))]));
function vskew(v) = [[0, -v[2], v[1], 0], [v[2], 0, -v[0], 0], [-v[1], v[0], 0, 0], [0, 0, 0, 0]];
function vrotate(to, from = VZ) = let(to = vnormalize(to), from = vnormalize(from)) let(c = cross(from, to), sc = vskew(c), nc = norm(c)) ((nc < VEPSILON) ? vmunit(4) : ((vmunit(4) + sc) + ((vsq(sc) * (1 - vdot(to, from))) / vsq(c))));
function _vcenter(v, center) = (center ? (-0.5 * abs(v)) : ((v < 0) ? v : 0));
function vcenter(size, center, centerx, centery, centerz) = let(vsize = (visnum(size) ? [size, size, size] : size), centers = vcenters(center, centerx, centery, centerz), vcenter = [for(i = vindexes(vsize)) (_vcenter(vsize[i], centers[i]))]) vtr(vcenter);
function vsquare(size, x, y, z) = let(v = vpoint(size, x = x, y = y, z = vopt(z, size.z, 0))) [[0, 0, v.z], [v.x, 0, v.z], [v.x, v.y, v.z], [0, v.y, v.z]];
function varc(r = 1, a = 90) = let(n = (($fn > 0.1) ? $fn : 10)) concat([[0, 0]], [for(i = vrange((n + 1), 0, (a / n))) ([(r * cos(i)), (r * sin(i))])]);
function vopt(param, def1, def2, def3) = ((param != undef) ? param : ((def1 != undef) ? def1 : ((def2 != undef) ? def2 : def3)));
function vpoint(size, x, y, z) = let(n = (visnum(size) ? size : undef)) [vopt(x, size[0], n, 1), vopt(y, size[1], n, 1), vopt(z, size[2], n, 1)];
function vcenters(center = false, centerx, centery, centerz) = let(center = vopt(center, false)) [vopt(centerx, center), vopt(centery, center), vopt(centerz, center)];
function visdef(param) = !is_undef(param);
function visundef(param) = is_undef(param);
function vislist(param) = (visdef(param) && is_list(param));
function visnum(param) = (visdef(param) && is_num(param));
function velem(list, pos, deflt, end) = let(l = (vislist(list) ? len(list) : 0), e = (visdef(end) ? end : 0), pos = vopt(pos, (l + e))) (visnum(list) ? ((pos == 0) ? list : vopt(deflt, list)) : ((pos < 0) ? vopt(deflt, list[0]) : ((pos >= l) ? vopt(deflt, list[(l - 1)]) : list[pos])));
function vorder(param) = ((visnum(param) || visundef(param)) ? [] : concat([len(param)], vorder(param[0])));
function vlevel(param) = len(vorder(param));
function vrange(nb, start = 0, inc = 1) = [start : inc : (start + (inc * (nb - 1)))];
function vindexes(v, start = 0, end = 0, inc = 1) = let(n = (visnum(v) ? v : len(v))) ((inc > 0) ? let(end = ((end > 0) ? (end - 1) : ((n - 1) + end))) [start : inc : end] : let(m = -inc, nb = ((end > 0) ? (end - 1) : (((n * m) + end) - 1))) [for(i = [0 : (n - 1)]) (for(j = [0 : (m - 1)]) (let(pos = ((i * m) + j)) (if(((pos >= start) && (pos <= nb))) (i))))]);
function vcopy(vs, start = 0, end = 0, inc = 1) = [for(i = vindexes(vs, start, end, inc)) (let(i = (i % len(vs))) ((i < 0) ? vs[(len(vs) + i)] : vs[i]))];
function vabs(v) = (visnum(v) ? abs(v) : [for(i = v) (abs(i))]);
function vsub2(l) = [for(i = vindexes(l, end = -1)) ((l[(i + 1)] - l[i]))];
function vsum2(l) = [for(i = vindexes(l, end = -1)) ((l[i] + l[(i + 1)]))];
function vlinear(i, a, b) = (a + ((b - a) * i));
function vlookup(i, v, n = 1) = let(pos = (((len(v) - 1) * i) / n), vi = floor(pos), t = (pos - vi), start = velem(v, vi), end = velem(v, (vi + 1))) vlinear(t, start, end);
function v2dto3d(pts, z = 0) = [for(pt = pts) ([pt.x, pt.y, z])];
function v3dto2d(pts) = [for(pt = pts) ([pt.x, pt.y])];
function vinverse(l) = let(n = len(l)) [for(i = [(n - 1) : -1 : 0]) (l[i])];
function vopt(param, def1, def2, def3) = ((param != undef) ? param : ((def1 != undef) ? def1 : ((def2 != undef) ? def2 : def3)));
function vpoint(size, x, y, z) = let(n = (visnum(size) ? size : undef)) [vopt(x, size[0], n, 1), vopt(y, size[1], n, 1), vopt(z, size[2], n, 1)];
function vcenters(center = false, centerx, centery, centerz) = let(center = vopt(center, false)) [vopt(centerx, center), vopt(centery, center), vopt(centerz, center)];
function visdef(param) = !is_undef(param);
function visundef(param) = is_undef(param);
function vislist(param) = (visdef(param) && is_list(param));
function visnum(param) = (visdef(param) && is_num(param));
function velem(list, pos, deflt, end) = let(l = (vislist(list) ? len(list) : 0), e = (visdef(end) ? end : 0), pos = vopt(pos, (l + e))) (visnum(list) ? ((pos == 0) ? list : vopt(deflt, list)) : ((pos < 0) ? vopt(deflt, list[0]) : ((pos >= l) ? vopt(deflt, list[(l - 1)]) : list[pos])));
function vorder(param) = ((visnum(param) || visundef(param)) ? [] : concat([len(param)], vorder(param[0])));
function vlevel(param) = len(vorder(param));
function vrange(nb, start = 0, inc = 1) = [start : inc : (start + (inc * (nb - 1)))];
function vindexes(v, start = 0, end = 0, inc = 1) = let(n = (visnum(v) ? v : len(v))) ((inc > 0) ? let(end = ((end > 0) ? (end - 1) : ((n - 1) + end))) [start : inc : end] : let(m = -inc, nb = ((end > 0) ? (end - 1) : (((n * m) + end) - 1))) [for(i = [0 : (n - 1)]) (for(j = [0 : (m - 1)]) (let(pos = ((i * m) + j)) (if(((pos >= start) && (pos <= nb))) (i))))]);
function vcopy(vs, start = 0, end = 0, inc = 1) = [for(i = vindexes(vs, start, end, inc)) (let(i = (i % len(vs))) ((i < 0) ? vs[(len(vs) + i)] : vs[i]))];
function vabs(v) = (visnum(v) ? abs(v) : [for(i = v) (abs(i))]);
function vsub2(l) = [for(i = vindexes(l, end = -1)) ((l[(i + 1)] - l[i]))];
function vsum2(l) = [for(i = vindexes(l, end = -1)) ((l[i] + l[(i + 1)]))];
function vlinear(i, a, b) = (a + ((b - a) * i));
function vlookup(i, v, n = 1) = let(pos = (((len(v) - 1) * i) / n), vi = floor(pos), t = (pos - vi), start = velem(v, vi), end = velem(v, (vi + 1))) vlinear(t, start, end);
function v2dto3d(pts, z = 0) = [for(pt = pts) ([pt.x, pt.y, z])];
function v3dto2d(pts) = [for(pt = pts) ([pt.x, pt.y])];
function vinverse(l) = let(n = len(l)) [for(i = [(n - 1) : -1 : 0]) (l[i])];
function vsq(x) = (x * x);
function vvect(n = 3, v1 = 1, pos = undef, v2 = 0) = ((pos == undef) ? [for(i = vrange(n)) (v1)] : [for(i = vrange(n)) (((i == pos) ? v1 : v2))]);
function vvnull(n) = vvect(n, 0);
function vvunary(n = 3) = vvect(n, 1);
function vvunit(n = 3, pos = 0) = vvect(n, 1, pos, 0);
function vvset(v, e, pos = 0) = (visnum(e) ? [for(i = vindexes(v)) (((i == pos) ? e : v[i]))] : [for(i = vindexes(v)) ((((i >= pos) && (i < (pos + len(e)))) ? e[(i - pos)] : v[i]))]);
function vvget(v, pos = 0) = let(n = len(v), p = (pos % n)) v[((p + n) % n)];
function vsum(v) = (v * vvunary(len(v)));
function vnorm(v) = sqrt((v * v));
function vdistance(a, b) = norm((a - b));
function vdist(a, b) = norm((a - b));
function vdot(a, b) = (a * b);
function vdet(a, b) = ((a.x * b.y) - (a.y * b.x));
function vnormalize(v) = (v / norm(v));
function vrotate2d(a) = [[cos(a), -sin(a)], [sin(a), cos(a)]];
function vmatrix(n = 3, v1 = 1, v2 = 0) = [for(i = vrange(n)) ([for(j = vrange(n)) (((i == j) ? v1 : v2))])];
function vmnull(n = 3) = vmatrix(n, 0, 0);
function vmunary(n = 3) = vmatrix(n, 1, 1);
function vmunit(n = 3) = vmatrix(n, 1, 0);
function vtr(x = 0, y = 0, z = 0) = ((vlevel(x) == 0) ? [[1, 0, 0, x], [0, 1, 0, y], [0, 0, 1, z], [0, 0, 0, 1]] : ((vlevel(x) == 1) ? vtr(x[0], x[1], x[2]) : [for(i = vindexes(x)) (vtr(x[i]))]));
function vtx(x) = vtr(x = x);
function vty(y) = vtr(y = y);
function vtz(z) = vtr(z = z);
function vrx(a) = [[1, 0, 0, 0], [0, cos(a), -sin(a), 0], [0, sin(a), cos(a), 0], [0, 0, 0, 1]];
function vry(a) = [[cos(a), 0, sin(a), 0], [0, 1, 0, 0], [-sin(a), 0, cos(a), 0], [0, 0, 0, 1]];
function vrz(a) = [[cos(a), -sin(a), 0, 0], [sin(a), cos(a), 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]];
function vscale(s = 1, x, y, z) = let(x = vopt(x, s), y = vopt(y, s), z = vopt(z, s)) ((vlevel(s) == 0) ? [[x, 0, 0, 0], [0, y, 0, 0], [0, 0, z, 0], [0, 0, 0, 1]] : ((vlevel(s) == 1) ? vscale(1, s[0], s[1], s[2]) : [for(v = s) (vscale(v))]));
function vskew(v) = [[0, -v[2], v[1], 0], [v[2], 0, -v[0], 0], [-v[1], v[0], 0, 0], [0, 0, 0, 0]];
function vrotate(to, from = VZ) = let(to = vnormalize(to), from = vnormalize(from)) let(c = cross(from, to), sc = vskew(c), nc = norm(c)) ((nc < VEPSILON) ? vmunit(4) : ((vmunit(4) + sc) + ((vsq(sc) * (1 - vdot(to, from))) / vsq(c))));
function _vcenter(v, center) = (center ? (-0.5 * abs(v)) : ((v < 0) ? v : 0));
function vcenter(size, center, centerx, centery, centerz) = let(vsize = (visnum(size) ? [size, size, size] : size), centers = vcenters(center, centerx, centery, centerz), vcenter = [for(i = vindexes(vsize)) (_vcenter(vsize[i], centers[i]))]) vtr(vcenter);
function vopt(param, def1, def2, def3) = ((param != undef) ? param : ((def1 != undef) ? def1 : ((def2 != undef) ? def2 : def3)));
function vpoint(size, x, y, z) = let(n = (visnum(size) ? size : undef)) [vopt(x, size[0], n, 1), vopt(y, size[1], n, 1), vopt(z, size[2], n, 1)];
function vcenters(center = false, centerx, centery, centerz) = let(center = vopt(center, false)) [vopt(centerx, center), vopt(centery, center), vopt(centerz, center)];
function visdef(param) = !is_undef(param);
function visundef(param) = is_undef(param);
function vislist(param) = (visdef(param) && is_list(param));
function visnum(param) = (visdef(param) && is_num(param));
function velem(list, pos, deflt, end) = let(l = (vislist(list) ? len(list) : 0), e = (visdef(end) ? end : 0), pos = vopt(pos, (l + e))) (visnum(list) ? ((pos == 0) ? list : vopt(deflt, list)) : ((pos < 0) ? vopt(deflt, list[0]) : ((pos >= l) ? vopt(deflt, list[(l - 1)]) : list[pos])));
function vorder(param) = ((visnum(param) || visundef(param)) ? [] : concat([len(param)], vorder(param[0])));
function vlevel(param) = len(vorder(param));
function vrange(nb, start = 0, inc = 1) = [start : inc : (start + (inc * (nb - 1)))];
function vindexes(v, start = 0, end = 0, inc = 1) = let(n = (visnum(v) ? v : len(v))) ((inc > 0) ? let(end = ((end > 0) ? (end - 1) : ((n - 1) + end))) [start : inc : end] : let(m = -inc, nb = ((end > 0) ? (end - 1) : (((n * m) + end) - 1))) [for(i = [0 : (n - 1)]) (for(j = [0 : (m - 1)]) (let(pos = ((i * m) + j)) (if(((pos >= start) && (pos <= nb))) (i))))]);
function vcopy(vs, start = 0, end = 0, inc = 1) = [for(i = vindexes(vs, start, end, inc)) (let(i = (i % len(vs))) ((i < 0) ? vs[(len(vs) + i)] : vs[i]))];
function vabs(v) = (visnum(v) ? abs(v) : [for(i = v) (abs(i))]);
function vsub2(l) = [for(i = vindexes(l, end = -1)) ((l[(i + 1)] - l[i]))];
function vsum2(l) = [for(i = vindexes(l, end = -1)) ((l[i] + l[(i + 1)]))];
function vlinear(i, a, b) = (a + ((b - a) * i));
function vlookup(i, v, n = 1) = let(pos = (((len(v) - 1) * i) / n), vi = floor(pos), t = (pos - vi), start = velem(v, vi), end = velem(v, (vi + 1))) vlinear(t, start, end);
function v2dto3d(pts, z = 0) = [for(pt = pts) ([pt.x, pt.y, z])];
function v3dto2d(pts) = [for(pt = pts) ([pt.x, pt.y])];
function vinverse(l) = let(n = len(l)) [for(i = [(n - 1) : -1 : 0]) (l[i])];
function vsq(x) = (x * x);
function vsquare(size, x, y, z) = let(v = vpoint(size, x = x, y = y, z = vopt(z, size.z, 0))) [[0, 0, v.z], [v.x, 0, v.z], [v.x, v.y, v.z], [0, v.y, v.z]];
function varc(r = 1, a = 90) = let(n = (($fn > 0.1) ? $fn : 10)) concat([[0, 0]], [for(i = vrange((n + 1), 0, (a / n))) ([(r * cos(i)), (r * sin(i))])]);
function vopt(param, def1, def2, def3) = ((param != undef) ? param : ((def1 != undef) ? def1 : ((def2 != undef) ? def2 : def3)));
function vpoint(size, x, y, z) = let(n = (visnum(size) ? size : undef)) [vopt(x, size[0], n, 1), vopt(y, size[1], n, 1), vopt(z, size[2], n, 1)];
function vcenters(center = false, centerx, centery, centerz) = let(center = vopt(center, false)) [vopt(centerx, center), vopt(centery, center), vopt(centerz, center)];
function visdef(param) = !is_undef(param);
function visundef(param) = is_undef(param);
function vislist(param) = (visdef(param) && is_list(param));
function visnum(param) = (visdef(param) && is_num(param));
function velem(list, pos, deflt, end) = let(l = (vislist(list) ? len(list) : 0), e = (visdef(end) ? end : 0), pos = vopt(pos, (l + e))) (visnum(list) ? ((pos == 0) ? list : vopt(deflt, list)) : ((pos < 0) ? vopt(deflt, list[0]) : ((pos >= l) ? vopt(deflt, list[(l - 1)]) : list[pos])));
function vorder(param) = ((visnum(param) || visundef(param)) ? [] : concat([len(param)], vorder(param[0])));
function vlevel(param) = len(vorder(param));
function vrange(nb, start = 0, inc = 1) = [start : inc : (start + (inc * (nb - 1)))];
function vindexes(v, start = 0, end = 0, inc = 1) = let(n = (visnum(v) ? v : len(v))) ((inc > 0) ? let(end = ((end > 0) ? (end - 1) : ((n - 1) + end))) [start : inc : end] : let(m = -inc, nb = ((end > 0) ? (end - 1) : (((n * m) + end) - 1))) [for(i = [0 : (n - 1)]) (for(j = [0 : (m - 1)]) (let(pos = ((i * m) + j)) (if(((pos >= start) && (pos <= nb))) (i))))]);
function vcopy(vs, start = 0, end = 0, inc = 1) = [for(i = vindexes(vs, start, end, inc)) (let(i = (i % len(vs))) ((i < 0) ? vs[(len(vs) + i)] : vs[i]))];
function vabs(v) = (visnum(v) ? abs(v) : [for(i = v) (abs(i))]);
function vsub2(l) = [for(i = vindexes(l, end = -1)) ((l[(i + 1)] - l[i]))];
function vsum2(l) = [for(i = vindexes(l, end = -1)) ((l[i] + l[(i + 1)]))];
function vlinear(i, a, b) = (a + ((b - a) * i));
function vlookup(i, v, n = 1) = let(pos = (((len(v) - 1) * i) / n), vi = floor(pos), t = (pos - vi), start = velem(v, vi), end = velem(v, (vi + 1))) vlinear(t, start, end);
function v2dto3d(pts, z = 0) = [for(pt = pts) ([pt.x, pt.y, z])];
function v3dto2d(pts) = [for(pt = pts) ([pt.x, pt.y])];
function vinverse(l) = let(n = len(l)) [for(i = [(n - 1) : -1 : 0]) (l[i])];
function vopt(param, def1, def2, def3) = ((param != undef) ? param : ((def1 != undef) ? def1 : ((def2 != undef) ? def2 : def3)));
function vpoint(size, x, y, z) = let(n = (visnum(size) ? size : undef)) [vopt(x, size[0], n, 1), vopt(y, size[1], n, 1), vopt(z, size[2], n, 1)];
function vcenters(center = false, centerx, centery, centerz) = let(center = vopt(center, false)) [vopt(centerx, center), vopt(centery, center), vopt(centerz, center)];
function visdef(param) = !is_undef(param);
function visundef(param) = is_undef(param);
function vislist(param) = (visdef(param) && is_list(param));
function visnum(param) = (visdef(param) && is_num(param));
function velem(list, pos, deflt, end) = let(l = (vislist(list) ? len(list) : 0), e = (visdef(end) ? end : 0), pos = vopt(pos, (l + e))) (visnum(list) ? ((pos == 0) ? list : vopt(deflt, list)) : ((pos < 0) ? vopt(deflt, list[0]) : ((pos >= l) ? vopt(deflt, list[(l - 1)]) : list[pos])));
function vorder(param) = ((visnum(param) || visundef(param)) ? [] : concat([len(param)], vorder(param[0])));
function vlevel(param) = len(vorder(param));
function vrange(nb, start = 0, inc = 1) = [start : inc : (start + (inc * (nb - 1)))];
function vindexes(v, start = 0, end = 0, inc = 1) = let(n = (visnum(v) ? v : len(v))) ((inc > 0) ? let(end = ((end > 0) ? (end - 1) : ((n - 1) + end))) [start : inc : end] : let(m = -inc, nb = ((end > 0) ? (end - 1) : (((n * m) + end) - 1))) [for(i = [0 : (n - 1)]) (for(j = [0 : (m - 1)]) (let(pos = ((i * m) + j)) (if(((pos >= start) && (pos <= nb))) (i))))]);
function vcopy(vs, start = 0, end = 0, inc = 1) = [for(i = vindexes(vs, start, end, inc)) (let(i = (i % len(vs))) ((i < 0) ? vs[(len(vs) + i)] : vs[i]))];
function vabs(v) = (visnum(v) ? abs(v) : [for(i = v) (abs(i))]);
function vsub2(l) = [for(i = vindexes(l, end = -1)) ((l[(i + 1)] - l[i]))];
function vsum2(l) = [for(i = vindexes(l, end = -1)) ((l[i] + l[(i + 1)]))];
function vlinear(i, a, b) = (a + ((b - a) * i));
function vlookup(i, v, n = 1) = let(pos = (((len(v) - 1) * i) / n), vi = floor(pos), t = (pos - vi), start = velem(v, vi), end = velem(v, (vi + 1))) vlinear(t, start, end);
function v2dto3d(pts, z = 0) = [for(pt = pts) ([pt.x, pt.y, z])];
function v3dto2d(pts) = [for(pt = pts) ([pt.x, pt.y])];
function vinverse(l) = let(n = len(l)) [for(i = [(n - 1) : -1 : 0]) (l[i])];
function vsq(x) = (x * x);
function vvect(n = 3, v1 = 1, pos = undef, v2 = 0) = ((pos == undef) ? [for(i = vrange(n)) (v1)] : [for(i = vrange(n)) (((i == pos) ? v1 : v2))]);
function vvnull(n) = vvect(n, 0);
function vvunary(n = 3) = vvect(n, 1);
function vvunit(n = 3, pos = 0) = vvect(n, 1, pos, 0);
function vvset(v, e, pos = 0) = (visnum(e) ? [for(i = vindexes(v)) (((i == pos) ? e : v[i]))] : [for(i = vindexes(v)) ((((i >= pos) && (i < (pos + len(e)))) ? e[(i - pos)] : v[i]))]);
function vvget(v, pos = 0) = let(n = len(v), p = (pos % n)) v[((p + n) % n)];
function vsum(v) = (v * vvunary(len(v)));
function vnorm(v) = sqrt((v * v));
function vdistance(a, b) = norm((a - b));
function vdist(a, b) = norm((a - b));
function vdot(a, b) = (a * b);
function vdet(a, b) = ((a.x * b.y) - (a.y * b.x));
function vnormalize(v) = (v / norm(v));
function vrotate2d(a) = [[cos(a), -sin(a)], [sin(a), cos(a)]];
function vmatrix(n = 3, v1 = 1, v2 = 0) = [for(i = vrange(n)) ([for(j = vrange(n)) (((i == j) ? v1 : v2))])];
function vmnull(n = 3) = vmatrix(n, 0, 0);
function vmunary(n = 3) = vmatrix(n, 1, 1);
function vmunit(n = 3) = vmatrix(n, 1, 0);
function vtr(x = 0, y = 0, z = 0) = ((vlevel(x) == 0) ? [[1, 0, 0, x], [0, 1, 0, y], [0, 0, 1, z], [0, 0, 0, 1]] : ((vlevel(x) == 1) ? vtr(x[0], x[1], x[2]) : [for(i = vindexes(x)) (vtr(x[i]))]));
function vtx(x) = vtr(x = x);
function vty(y) = vtr(y = y);
function vtz(z) = vtr(z = z);
function vrx(a) = [[1, 0, 0, 0], [0, cos(a), -sin(a), 0], [0, sin(a), cos(a), 0], [0, 0, 0, 1]];
function vry(a) = [[cos(a), 0, sin(a), 0], [0, 1, 0, 0], [-sin(a), 0, cos(a), 0], [0, 0, 0, 1]];
function vrz(a) = [[cos(a), -sin(a), 0, 0], [sin(a), cos(a), 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]];
function vscale(s = 1, x, y, z) = let(x = vopt(x, s), y = vopt(y, s), z = vopt(z, s)) ((vlevel(s) == 0) ? [[x, 0, 0, 0], [0, y, 0, 0], [0, 0, z, 0], [0, 0, 0, 1]] : ((vlevel(s) == 1) ? vscale(1, s[0], s[1], s[2]) : [for(v = s) (vscale(v))]));
function vskew(v) = [[0, -v[2], v[1], 0], [v[2], 0, -v[0], 0], [-v[1], v[0], 0, 0], [0, 0, 0, 0]];
function vrotate(to, from = VZ) = let(to = vnormalize(to), from = vnormalize(from)) let(c = cross(from, to), sc = vskew(c), nc = norm(c)) ((nc < VEPSILON) ? vmunit(4) : ((vmunit(4) + sc) + ((vsq(sc) * (1 - vdot(to, from))) / vsq(c))));
function _vcenter(v, center) = (center ? (-0.5 * abs(v)) : ((v < 0) ? v : 0));
function vcenter(size, center, centerx, centery, centerz) = let(vsize = (visnum(size) ? [size, size, size] : size), centers = vcenters(center, centerx, centery, centerz), vcenter = [for(i = vindexes(vsize)) (_vcenter(vsize[i], centers[i]))]) vtr(vcenter);
function vmatrix(n = 3, v1 = 1, v2 = 0) = [for(i = vrange(n)) ([for(j = vrange(n)) (((i == j) ? v1 : v2))])];
function vmnull(n = 3) = vmatrix(n, 0, 0);
function vmunary(n = 3) = vmatrix(n, 1, 1);
function vmunit(n = 3) = vmatrix(n, 1, 0);
function vopt(param, def1, def2, def3) = ((param != undef) ? param : ((def1 != undef) ? def1 : ((def2 != undef) ? def2 : def3)));
function vpoint(size, x, y, z) = let(n = (visnum(size) ? size : undef)) [vopt(x, size[0], n, 1), vopt(y, size[1], n, 1), vopt(z, size[2], n, 1)];
function vcenters(center = false, centerx, centery, centerz) = let(center = vopt(center, false)) [vopt(centerx, center), vopt(centery, center), vopt(centerz, center)];
function visdef(param) = !is_undef(param);
function visundef(param) = is_undef(param);
function vislist(param) = (visdef(param) && is_list(param));
function visnum(param) = (visdef(param) && is_num(param));
function velem(list, pos, deflt, end) = let(l = (vislist(list) ? len(list) : 0), e = (visdef(end) ? end : 0), pos = vopt(pos, (l + e))) (visnum(list) ? ((pos == 0) ? list : vopt(deflt, list)) : ((pos < 0) ? vopt(deflt, list[0]) : ((pos >= l) ? vopt(deflt, list[(l - 1)]) : list[pos])));
function vorder(param) = ((visnum(param) || visundef(param)) ? [] : concat([len(param)], vorder(param[0])));
function vlevel(param) = len(vorder(param));
function vrange(nb, start = 0, inc = 1) = [start : inc : (start + (inc * (nb - 1)))];
function vindexes(v, start = 0, end = 0, inc = 1) = let(n = (visnum(v) ? v : len(v))) ((inc > 0) ? let(end = ((end > 0) ? (end - 1) : ((n - 1) + end))) [start : inc : end] : let(m = -inc, nb = ((end > 0) ? (end - 1) : (((n * m) + end) - 1))) [for(i = [0 : (n - 1)]) (for(j = [0 : (m - 1)]) (let(pos = ((i * m) + j)) (if(((pos >= start) && (pos <= nb))) (i))))]);
function vcopy(vs, start = 0, end = 0, inc = 1) = [for(i = vindexes(vs, start, end, inc)) (let(i = (i % len(vs))) ((i < 0) ? vs[(len(vs) + i)] : vs[i]))];
function vabs(v) = (visnum(v) ? abs(v) : [for(i = v) (abs(i))]);
function vsub2(l) = [for(i = vindexes(l, end = -1)) ((l[(i + 1)] - l[i]))];
function vsum2(l) = [for(i = vindexes(l, end = -1)) ((l[i] + l[(i + 1)]))];
function vlinear(i, a, b) = (a + ((b - a) * i));
function vlookup(i, v, n = 1) = let(pos = (((len(v) - 1) * i) / n), vi = floor(pos), t = (pos - vi), start = velem(v, vi), end = velem(v, (vi + 1))) vlinear(t, start, end);
function v2dto3d(pts, z = 0) = [for(pt = pts) ([pt.x, pt.y, z])];
function v3dto2d(pts) = [for(pt = pts) ([pt.x, pt.y])];
function vinverse(l) = let(n = len(l)) [for(i = [(n - 1) : -1 : 0]) (l[i])];
function vcut_pt(ps, t, start = 0) = (((1 - t) * ps[start]) + (t * ps[(start + 1)]));
function vcut_pts(ps, b, n, start = 0) = [for(i = [b : n]) (let(t = (i / n)) vcut_pt(ps, t, start))];
function vcut(ps) = let(n = (($fn <= 0) ? 10 : $fn)) [for(i = vindexes(ps, end = -1)) (for(pt = vcut_pts(ps, ((i == 0) ? 0 : 1), n, i)) (pt))];
function vbezier3_pt(ps, t, start = 0) = (((vsq((1 - t)) * ps[start]) + (((2 * t) * (1 - t)) * ps[(start + 1)])) + (vsq(t) * ps[(start + 2)]));
function vbezier3_pts(ps, n, b = 0, start = 0) = [for(i = [b : n]) (let(t = (i / n)) vbezier3_pt(ps, t, start))];
function vbezier3(ps) = let(n = (($fn <= 0) ? 10 : $fn)) [for(i = vindexes(ps, inc = 2, end = -1)) (for(pt = vbezier3_pts(ps, n, ((i == 0) ? 0 : 1), i)) (pt))];
function vbezier4_pt(ps, t, start = 0) = ((((pow((1 - t), 3) * ps[start]) + (((3 * t) * vsq((1 - t))) * ps[(start + 1)])) + (((3 * vsq(t)) * (1 - t)) * ps[(start + 2)])) + (pow(t, 3) * ps[(start + 3)]));
function vbezier4_pts(ps, n, b = 0, start = 0) = [for(i = [b : n]) (let(t = (i / n)) vbezier4_pt(ps, t, start))];
function vbezier4(ps) = let(n = (($fn <= 0) ? 10 : $fn)) [for(i = vindexes(ps, inc = 3, end = -1)) (for(pt = vbezier4_pts(ps, n, ((i == 0) ? 0 : 1), i)) (pt))];
function vcontrol_pt(ps, t = 1, start = 0) = (ps[(start + 1)] + (((ps[(start + 2)] - ps[start]) / 2) * t));
function vcontrol_pts(ps, start = 0, c = 0.5) = [for(t = [-1 : 1]) (vcontrol_pt(ps, (t * c), start))];
function vcontrol(ps, c = 0.5) = let(first = ps[0], last = velem(ps, end = -1)) concat([first, first], [for(i = vindexes(ps, start = 1, end = -1)) (for(pt = vcontrol_pts(ps, (i - 1), c)) (pt))], [last, last]);
function vcorner(pts, r) = let(d1 = vdist(pts[1], pts[0]), d2 = vdist(pts[2], pts[1])) let(r1 = (vislist(r) ? r[0] : r), r2 = (vislist(r) ? r[1] : r)) [vlinear((1 - (r1 / d1)), pts[0], pts[1]), pts[1], vlinear((r2 / d2), pts[1], pts[2])];
function vround_ident(pts, r) = [pts[1]];
function vround_path_base(pts, rs, round_func) = let(f = vopt(round_func, function(pts) vround_ident(pts))) [for(i = vrange(len(pts))) (each (((rs[i] == 0) ? [pts[i]] : let(3pts = vcopy(pts, (i - 1), (i + 2)), c = vcorner(3pts, rs[i])) f(c))))];
function vround_cut(pts, r) = [pts[0], pts[2]];
function vround_cut_path(pts, rs) = vround_path_base(pts, rs, function(pts) vround_cut(pts));
function vround_bezier(pts) = let(n = (($fn > 0.1) ? $fn : 10)) vbezier3_pts(pts, n);
function vround_bezier_path(pts, rs) = vround_path_base(pts, rs, function(pts) vround_bezier(pts));
function vround_path(pts, rs) = vround_bezier_path(pts, rs);
function vadd(pts, v) = [for(p = pts) ((p + v))];
function vopt(param, def1, def2, def3) = ((param != undef) ? param : ((def1 != undef) ? def1 : ((def2 != undef) ? def2 : def3)));
function vpoint(size, x, y, z) = let(n = (visnum(size) ? size : undef)) [vopt(x, size[0], n, 1), vopt(y, size[1], n, 1), vopt(z, size[2], n, 1)];
function vcenters(center = false, centerx, centery, centerz) = let(center = vopt(center, false)) [vopt(centerx, center), vopt(centery, center), vopt(centerz, center)];
function visdef(param) = !is_undef(param);
function visundef(param) = is_undef(param);
function vislist(param) = (visdef(param) && is_list(param));
function visnum(param) = (visdef(param) && is_num(param));
function velem(list, pos, deflt, end) = let(l = (vislist(list) ? len(list) : 0), e = (visdef(end) ? end : 0), pos = vopt(pos, (l + e))) (visnum(list) ? ((pos == 0) ? list : vopt(deflt, list)) : ((pos < 0) ? vopt(deflt, list[0]) : ((pos >= l) ? vopt(deflt, list[(l - 1)]) : list[pos])));
function vorder(param) = ((visnum(param) || visundef(param)) ? [] : concat([len(param)], vorder(param[0])));
function vlevel(param) = len(vorder(param));
function vrange(nb, start = 0, inc = 1) = [start : inc : (start + (inc * (nb - 1)))];
function vindexes(v, start = 0, end = 0, inc = 1) = let(n = (visnum(v) ? v : len(v))) ((inc > 0) ? let(end = ((end > 0) ? (end - 1) : ((n - 1) + end))) [start : inc : end] : let(m = -inc, nb = ((end > 0) ? (end - 1) : (((n * m) + end) - 1))) [for(i = [0 : (n - 1)]) (for(j = [0 : (m - 1)]) (let(pos = ((i * m) + j)) (if(((pos >= start) && (pos <= nb))) (i))))]);
function vcopy(vs, start = 0, end = 0, inc = 1) = [for(i = vindexes(vs, start, end, inc)) (let(i = (i % len(vs))) ((i < 0) ? vs[(len(vs) + i)] : vs[i]))];
function vabs(v) = (visnum(v) ? abs(v) : [for(i = v) (abs(i))]);
function vsub2(l) = [for(i = vindexes(l, end = -1)) ((l[(i + 1)] - l[i]))];
function vsum2(l) = [for(i = vindexes(l, end = -1)) ((l[i] + l[(i + 1)]))];
function vlinear(i, a, b) = (a + ((b - a) * i));
function vlookup(i, v, n = 1) = let(pos = (((len(v) - 1) * i) / n), vi = floor(pos), t = (pos - vi), start = velem(v, vi), end = velem(v, (vi + 1))) vlinear(t, start, end);
function v2dto3d(pts, z = 0) = [for(pt = pts) ([pt.x, pt.y, z])];
function v3dto2d(pts) = [for(pt = pts) ([pt.x, pt.y])];
function vinverse(l) = let(n = len(l)) [for(i = [(n - 1) : -1 : 0]) (l[i])];
function vsq(x) = (x * x);
function vvect(n = 3, v1 = 1, pos = undef, v2 = 0) = ((pos == undef) ? [for(i = vrange(n)) (v1)] : [for(i = vrange(n)) (((i == pos) ? v1 : v2))]);
function vvnull(n) = vvect(n, 0);
function vvunary(n = 3) = vvect(n, 1);
function vvunit(n = 3, pos = 0) = vvect(n, 1, pos, 0);
function vvset(v, e, pos = 0) = (visnum(e) ? [for(i = vindexes(v)) (((i == pos) ? e : v[i]))] : [for(i = vindexes(v)) ((((i >= pos) && (i < (pos + len(e)))) ? e[(i - pos)] : v[i]))]);
function vvget(v, pos = 0) = let(n = len(v), p = (pos % n)) v[((p + n) % n)];
function vsum(v) = (v * vvunary(len(v)));
function vnorm(v) = sqrt((v * v));
function vdistance(a, b) = norm((a - b));
function vdist(a, b) = norm((a - b));
function vdot(a, b) = (a * b);
function vdet(a, b) = ((a.x * b.y) - (a.y * b.x));
function vnormalize(v) = (v / norm(v));
function vrotate2d(a) = [[cos(a), -sin(a)], [sin(a), cos(a)]];
function vmatrix(n = 3, v1 = 1, v2 = 0) = [for(i = vrange(n)) ([for(j = vrange(n)) (((i == j) ? v1 : v2))])];
function vmnull(n = 3) = vmatrix(n, 0, 0);
function vmunary(n = 3) = vmatrix(n, 1, 1);
function vmunit(n = 3) = vmatrix(n, 1, 0);
function vtr(x = 0, y = 0, z = 0) = ((vlevel(x) == 0) ? [[1, 0, 0, x], [0, 1, 0, y], [0, 0, 1, z], [0, 0, 0, 1]] : ((vlevel(x) == 1) ? vtr(x[0], x[1], x[2]) : [for(i = vindexes(x)) (vtr(x[i]))]));
function vtx(x) = vtr(x = x);
function vty(y) = vtr(y = y);
function vtz(z) = vtr(z = z);
function vrx(a) = [[1, 0, 0, 0], [0, cos(a), -sin(a), 0], [0, sin(a), cos(a), 0], [0, 0, 0, 1]];
function vry(a) = [[cos(a), 0, sin(a), 0], [0, 1, 0, 0], [-sin(a), 0, cos(a), 0], [0, 0, 0, 1]];
function vrz(a) = [[cos(a), -sin(a), 0, 0], [sin(a), cos(a), 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]];
function vscale(s = 1, x, y, z) = let(x = vopt(x, s), y = vopt(y, s), z = vopt(z, s)) ((vlevel(s) == 0) ? [[x, 0, 0, 0], [0, y, 0, 0], [0, 0, z, 0], [0, 0, 0, 1]] : ((vlevel(s) == 1) ? vscale(1, s[0], s[1], s[2]) : [for(v = s) (vscale(v))]));
function vskew(v) = [[0, -v[2], v[1], 0], [v[2], 0, -v[0], 0], [-v[1], v[0], 0, 0], [0, 0, 0, 0]];
function vrotate(to, from = VZ) = let(to = vnormalize(to), from = vnormalize(from)) let(c = cross(from, to), sc = vskew(c), nc = norm(c)) ((nc < VEPSILON) ? vmunit(4) : ((vmunit(4) + sc) + ((vsq(sc) * (1 - vdot(to, from))) / vsq(c))));
function _vcenter(v, center) = (center ? (-0.5 * abs(v)) : ((v < 0) ? v : 0));
function vcenter(size, center, centerx, centery, centerz) = let(vsize = (visnum(size) ? [size, size, size] : size), centers = vcenters(center, centerx, centery, centerz), vcenter = [for(i = vindexes(vsize)) (_vcenter(vsize[i], centers[i]))]) vtr(vcenter);
function vopt(param, def1, def2, def3) = ((param != undef) ? param : ((def1 != undef) ? def1 : ((def2 != undef) ? def2 : def3)));
function vpoint(size, x, y, z) = let(n = (visnum(size) ? size : undef)) [vopt(x, size[0], n, 1), vopt(y, size[1], n, 1), vopt(z, size[2], n, 1)];
function vcenters(center = false, centerx, centery, centerz) = let(center = vopt(center, false)) [vopt(centerx, center), vopt(centery, center), vopt(centerz, center)];
function visdef(param) = !is_undef(param);
function visundef(param) = is_undef(param);
function vislist(param) = (visdef(param) && is_list(param));
function visnum(param) = (visdef(param) && is_num(param));
function velem(list, pos, deflt, end) = let(l = (vislist(list) ? len(list) : 0), e = (visdef(end) ? end : 0), pos = vopt(pos, (l + e))) (visnum(list) ? ((pos == 0) ? list : vopt(deflt, list)) : ((pos < 0) ? vopt(deflt, list[0]) : ((pos >= l) ? vopt(deflt, list[(l - 1)]) : list[pos])));
function vorder(param) = ((visnum(param) || visundef(param)) ? [] : concat([len(param)], vorder(param[0])));
function vlevel(param) = len(vorder(param));
function vrange(nb, start = 0, inc = 1) = [start : inc : (start + (inc * (nb - 1)))];
function vindexes(v, start = 0, end = 0, inc = 1) = let(n = (visnum(v) ? v : len(v))) ((inc > 0) ? let(end = ((end > 0) ? (end - 1) : ((n - 1) + end))) [start : inc : end] : let(m = -inc, nb = ((end > 0) ? (end - 1) : (((n * m) + end) - 1))) [for(i = [0 : (n - 1)]) (for(j = [0 : (m - 1)]) (let(pos = ((i * m) + j)) (if(((pos >= start) && (pos <= nb))) (i))))]);
function vcopy(vs, start = 0, end = 0, inc = 1) = [for(i = vindexes(vs, start, end, inc)) (let(i = (i % len(vs))) ((i < 0) ? vs[(len(vs) + i)] : vs[i]))];
function vabs(v) = (visnum(v) ? abs(v) : [for(i = v) (abs(i))]);
function vsub2(l) = [for(i = vindexes(l, end = -1)) ((l[(i + 1)] - l[i]))];
function vsum2(l) = [for(i = vindexes(l, end = -1)) ((l[i] + l[(i + 1)]))];
function vlinear(i, a, b) = (a + ((b - a) * i));
function vlookup(i, v, n = 1) = let(pos = (((len(v) - 1) * i) / n), vi = floor(pos), t = (pos - vi), start = velem(v, vi), end = velem(v, (vi + 1))) vlinear(t, start, end);
function v2dto3d(pts, z = 0) = [for(pt = pts) ([pt.x, pt.y, z])];
function v3dto2d(pts) = [for(pt = pts) ([pt.x, pt.y])];
function vinverse(l) = let(n = len(l)) [for(i = [(n - 1) : -1 : 0]) (l[i])];
function vcut_pt(ps, t, start = 0) = (((1 - t) * ps[start]) + (t * ps[(start + 1)]));
function vcut_pts(ps, b, n, start = 0) = [for(i = [b : n]) (let(t = (i / n)) vcut_pt(ps, t, start))];
function vcut(ps) = let(n = (($fn <= 0) ? 10 : $fn)) [for(i = vindexes(ps, end = -1)) (for(pt = vcut_pts(ps, ((i == 0) ? 0 : 1), n, i)) (pt))];
function vbezier3_pt(ps, t, start = 0) = (((vsq((1 - t)) * ps[start]) + (((2 * t) * (1 - t)) * ps[(start + 1)])) + (vsq(t) * ps[(start + 2)]));
function vbezier3_pts(ps, n, b = 0, start = 0) = [for(i = [b : n]) (let(t = (i / n)) vbezier3_pt(ps, t, start))];
function vbezier3(ps) = let(n = (($fn <= 0) ? 10 : $fn)) [for(i = vindexes(ps, inc = 2, end = -1)) (for(pt = vbezier3_pts(ps, n, ((i == 0) ? 0 : 1), i)) (pt))];
function vbezier4_pt(ps, t, start = 0) = ((((pow((1 - t), 3) * ps[start]) + (((3 * t) * vsq((1 - t))) * ps[(start + 1)])) + (((3 * vsq(t)) * (1 - t)) * ps[(start + 2)])) + (pow(t, 3) * ps[(start + 3)]));
function vbezier4_pts(ps, n, b = 0, start = 0) = [for(i = [b : n]) (let(t = (i / n)) vbezier4_pt(ps, t, start))];
function vbezier4(ps) = let(n = (($fn <= 0) ? 10 : $fn)) [for(i = vindexes(ps, inc = 3, end = -1)) (for(pt = vbezier4_pts(ps, n, ((i == 0) ? 0 : 1), i)) (pt))];
function vcontrol_pt(ps, t = 1, start = 0) = (ps[(start + 1)] + (((ps[(start + 2)] - ps[start]) / 2) * t));
function vcontrol_pts(ps, start = 0, c = 0.5) = [for(t = [-1 : 1]) (vcontrol_pt(ps, (t * c), start))];
function vcontrol(ps, c = 0.5) = let(first = ps[0], last = velem(ps, end = -1)) concat([first, first], [for(i = vindexes(ps, start = 1, end = -1)) (for(pt = vcontrol_pts(ps, (i - 1), c)) (pt))], [last, last]);
function vcorner(pts, r) = let(d1 = vdist(pts[1], pts[0]), d2 = vdist(pts[2], pts[1])) let(r1 = (vislist(r) ? r[0] : r), r2 = (vislist(r) ? r[1] : r)) [vlinear((1 - (r1 / d1)), pts[0], pts[1]), pts[1], vlinear((r2 / d2), pts[1], pts[2])];
function vround_ident(pts, r) = [pts[1]];
function vround_path_base(pts, rs, round_func) = let(f = vopt(round_func, function(pts) vround_ident(pts))) [for(i = vrange(len(pts))) (each (((rs[i] == 0) ? [pts[i]] : let(3pts = vcopy(pts, (i - 1), (i + 2)), c = vcorner(3pts, rs[i])) f(c))))];
function vround_cut(pts, r) = [pts[0], pts[2]];
function vround_cut_path(pts, rs) = vround_path_base(pts, rs, function(pts) vround_cut(pts));
function vround_bezier(pts) = let(n = (($fn > 0.1) ? $fn : 10)) vbezier3_pts(pts, n);
function vround_bezier_path(pts, rs) = vround_path_base(pts, rs, function(pts) vround_bezier(pts));
function vround_path(pts, rs) = vround_bezier_path(pts, rs);
function vadd(pts, v) = [for(p = pts) ((p + v))];
function vopt(param, def1, def2, def3) = ((param != undef) ? param : ((def1 != undef) ? def1 : ((def2 != undef) ? def2 : def3)));
function vpoint(size, x, y, z) = let(n = (visnum(size) ? size : undef)) [vopt(x, size[0], n, 1), vopt(y, size[1], n, 1), vopt(z, size[2], n, 1)];
function vcenters(center = false, centerx, centery, centerz) = let(center = vopt(center, false)) [vopt(centerx, center), vopt(centery, center), vopt(centerz, center)];
function visdef(param) = !is_undef(param);
function visundef(param) = is_undef(param);
function vislist(param) = (visdef(param) && is_list(param));
function visnum(param) = (visdef(param) && is_num(param));
function velem(list, pos, deflt, end) = let(l = (vislist(list) ? len(list) : 0), e = (visdef(end) ? end : 0), pos = vopt(pos, (l + e))) (visnum(list) ? ((pos == 0) ? list : vopt(deflt, list)) : ((pos < 0) ? vopt(deflt, list[0]) : ((pos >= l) ? vopt(deflt, list[(l - 1)]) : list[pos])));
function vorder(param) = ((visnum(param) || visundef(param)) ? [] : concat([len(param)], vorder(param[0])));
function vlevel(param) = len(vorder(param));
function vrange(nb, start = 0, inc = 1) = [start : inc : (start + (inc * (nb - 1)))];
function vindexes(v, start = 0, end = 0, inc = 1) = let(n = (visnum(v) ? v : len(v))) ((inc > 0) ? let(end = ((end > 0) ? (end - 1) : ((n - 1) + end))) [start : inc : end] : let(m = -inc, nb = ((end > 0) ? (end - 1) : (((n * m) + end) - 1))) [for(i = [0 : (n - 1)]) (for(j = [0 : (m - 1)]) (let(pos = ((i * m) + j)) (if(((pos >= start) && (pos <= nb))) (i))))]);
function vcopy(vs, start = 0, end = 0, inc = 1) = [for(i = vindexes(vs, start, end, inc)) (let(i = (i % len(vs))) ((i < 0) ? vs[(len(vs) + i)] : vs[i]))];
function vabs(v) = (visnum(v) ? abs(v) : [for(i = v) (abs(i))]);
function vsub2(l) = [for(i = vindexes(l, end = -1)) ((l[(i + 1)] - l[i]))];
function vsum2(l) = [for(i = vindexes(l, end = -1)) ((l[i] + l[(i + 1)]))];
function vlinear(i, a, b) = (a + ((b - a) * i));
function vlookup(i, v, n = 1) = let(pos = (((len(v) - 1) * i) / n), vi = floor(pos), t = (pos - vi), start = velem(v, vi), end = velem(v, (vi + 1))) vlinear(t, start, end);
function v2dto3d(pts, z = 0) = [for(pt = pts) ([pt.x, pt.y, z])];
function v3dto2d(pts) = [for(pt = pts) ([pt.x, pt.y])];
function vinverse(l) = let(n = len(l)) [for(i = [(n - 1) : -1 : 0]) (l[i])];
function vcut_pt(ps, t, start = 0) = (((1 - t) * ps[start]) + (t * ps[(start + 1)]));
function vcut_pts(ps, b, n, start = 0) = [for(i = [b : n]) (let(t = (i / n)) vcut_pt(ps, t, start))];
function vcut(ps) = let(n = (($fn <= 0) ? 10 : $fn)) [for(i = vindexes(ps, end = -1)) (for(pt = vcut_pts(ps, ((i == 0) ? 0 : 1), n, i)) (pt))];
function vbezier3_pt(ps, t, start = 0) = (((vsq((1 - t)) * ps[start]) + (((2 * t) * (1 - t)) * ps[(start + 1)])) + (vsq(t) * ps[(start + 2)]));
function vbezier3_pts(ps, n, b = 0, start = 0) = [for(i = [b : n]) (let(t = (i / n)) vbezier3_pt(ps, t, start))];
function vbezier3(ps) = let(n = (($fn <= 0) ? 10 : $fn)) [for(i = vindexes(ps, inc = 2, end = -1)) (for(pt = vbezier3_pts(ps, n, ((i == 0) ? 0 : 1), i)) (pt))];
function vbezier4_pt(ps, t, start = 0) = ((((pow((1 - t), 3) * ps[start]) + (((3 * t) * vsq((1 - t))) * ps[(start + 1)])) + (((3 * vsq(t)) * (1 - t)) * ps[(start + 2)])) + (pow(t, 3) * ps[(start + 3)]));
function vbezier4_pts(ps, n, b = 0, start = 0) = [for(i = [b : n]) (let(t = (i / n)) vbezier4_pt(ps, t, start))];
function vbezier4(ps) = let(n = (($fn <= 0) ? 10 : $fn)) [for(i = vindexes(ps, inc = 3, end = -1)) (for(pt = vbezier4_pts(ps, n, ((i == 0) ? 0 : 1), i)) (pt))];
function vcontrol_pt(ps, t = 1, start = 0) = (ps[(start + 1)] + (((ps[(start + 2)] - ps[start]) / 2) * t));
function vcontrol_pts(ps, start = 0, c = 0.5) = [for(t = [-1 : 1]) (vcontrol_pt(ps, (t * c), start))];
function vcontrol(ps, c = 0.5) = let(first = ps[0], last = velem(ps, end = -1)) concat([first, first], [for(i = vindexes(ps, start = 1, end = -1)) (for(pt = vcontrol_pts(ps, (i - 1), c)) (pt))], [last, last]);
function vcorner(pts, r) = let(d1 = vdist(pts[1], pts[0]), d2 = vdist(pts[2], pts[1])) let(r1 = (vislist(r) ? r[0] : r), r2 = (vislist(r) ? r[1] : r)) [vlinear((1 - (r1 / d1)), pts[0], pts[1]), pts[1], vlinear((r2 / d2), pts[1], pts[2])];
function vround_ident(pts, r) = [pts[1]];
function vround_path_base(pts, rs, round_func) = let(f = vopt(round_func, function(pts) vround_ident(pts))) [for(i = vrange(len(pts))) (each (((rs[i] == 0) ? [pts[i]] : let(3pts = vcopy(pts, (i - 1), (i + 2)), c = vcorner(3pts, rs[i])) f(c))))];
function vround_cut(pts, r) = [pts[0], pts[2]];
function vround_cut_path(pts, rs) = vround_path_base(pts, rs, function(pts) vround_cut(pts));
function vround_bezier(pts) = let(n = (($fn > 0.1) ? $fn : 10)) vbezier3_pts(pts, n);
function vround_bezier_path(pts, rs) = vround_path_base(pts, rs, function(pts) vround_bezier(pts));
function vround_path(pts, rs) = vround_bezier_path(pts, rs);
function vadd(pts, v) = [for(p = pts) ((p + v))];
function vfollow(v, o = V0, s = 1, t = 0) = ((vlevel(v) == 1) ? let(l = norm(v), c = ((l > 0) ? acos((v[2] / l)) : 0), l2 = norm([v[0], v[1], 0]), b = ((l2 > 0) ? acos((v[0] / l2)) : 0)) ((((vtr(o) * vrz((90 + (b * ((v[1] > 0) ? 1 : -1))))) * vrx(c)) * vscale(s)) * vrz(t)) : let(n = len(v), vs = (visnum(s) ? [1, s] : s), ts = (visnum(t) ? [0, t] : t)) [for(i = vindexes(v)) (vfollow(v[i], o[i], vlookup(i, vs, n), vlookup(i, ts, n)))]);
function vfollow_simple(path, s = 1, t = 0) = let(ps = (($fn <= 0) ? path : vcut(path)), vs = vvect(len(ps), VZ)) vfollow(vs, ps, s, t);
function vfollow_direct(path, s = 1, t = 0) = let(ps = (($fn <= 0) ? path : vcut(path)), tvs = vsub2(ps), last = velem(tvs, end = -1), vs = concat(tvs, [last])) vfollow(vs, ps, s, t);
function vfollow_middle(path, s = 1, t = 0) = let(ps = path, tvs = vsub2(path), first = tvs[0], last = velem(tvs, end = -1), vs = concat([first], vsum2(tvs), [last])) vfollow(vs, ps, s, t);
function vfollow_dup(path, s = 1, t = 0) = let(ps = vcopy(path, start = 1, end = -1, inc = -2), vs = vcopy(vsub2(path), inc = -2)) vfollow(vs, ps, s, t);
function vfollow_bezier3(path, s = 1, t = 0) = vfollow_direct(vbezier3(path), s, t, $fn = 0);
function vfollow_bezier4(path, s = 1, t = 0, c = 0.5) = let(ps = ((c == 0) ? path : vcontrol(path, c))) vfollow_direct(vbezier4(ps), s, t, $fn = 0);
function vfollow_rot(a = 360, r, s = 1, d, normal = VY, h = 0) = let(n = (($fn <= 0) ? min(4, round(((13 * a) / 360))) : $fn), vs = (visnum(s) ? [1, s] : s), r = vopt(r, (d / 2), 0)) [for(i = [0 : n]) (((((vtz(((h / n) * i)) * vrz(((a / n) * i))) * vtx(r)) * vrotate(normal)) * vscale(vlookup(i, vs, n))))];
function vhelix(h = 5, p = 1, r, s = 1, d, a, n = VZ) = let(nb = (h / p), a = vopt(a, (360 * nb)), fn = (($fn <= 0) ? (13 * nb) : $fn)) vfollow_rot(a = a, r = r, s = s, d = d, normal = n, h = h, $fn = fn);
function rebord_coin(o, r, r1, b = 0, p = V0) = let(a = (b % 90)) let(pr = (floor((b / 90)) * 90)) let(t = (1 - tan(a))) let(p1 = [(o.y - (sin(a) * r)), (o.z - (cos(a) * r))]) let(p2 = ((t > 0) ? [(o.y * t), 0] : [0, (o.z - (o.z / tan(a)))])) let(p1r = (vrotate2d(pr) * p1)) let(p2r = (vrotate2d(pr) * p2)) let(pts = [[o.x, p1r.x, p1r.y], [o.x, p2r.x, p2r.y], [0, p2r.x, p2r.y], [0, p1r.x, p1r.y]]) let(rs = [r1, 0, 0, 0]) vround_path(vadd(pts, p), rs, $fn = 4);
function squareyz(d) = [[0, 0, 0], [0, d.y, 0], [0, d.y, d.z], [0, 0, d.z]];
function faceyz(d, rs) = let(pts = squareyz(d)) vround_path(pts, rs);
module vblue() {
	color("blue") children();
}
module vred() {
	color("red") children();
}
module vwhite() {
	color("white") children();
}
module vgray() {
	color("gray") children();
}
module vtr(x = 0, y = 0, z = 0) {
	v = (vislist(x) ? x : [x, y, z]);
	translate(v) children();
}
module vtx(x) {
	translate([x, 0, 0]) children();
}
module vty(y) {
	translate([0, y, 0]) children();
}
module vtz(z) {
	translate([0, 0, z]) children();
}
module vrx(angle) {
	multmatrix(vrx(angle)) children();
}
module vry(angle) {
	multmatrix(vry(angle)) children();
}
module vrz(angle, center = undef) {
	center = vopt(center, V0);
	translate(center) rotate(angle) translate(-center) children();
}
module vscale(s = 1, x = undef, y = undef, z = undef) {
	multmatrix(vscale(s, x, y, z)) children();
}
module vrotate(to, from = VZ) {
	multmatrix(vrotate(to, from)) children();
}
module vfollow(v, p = V0, s = 1, t = 0) {
	multmatrix(vfollow(v, p, s, t)) children();
}
module vcenter(size, center, centerx, centery, centerz) {
	multmatrix(vcenter(size, center, centerx, centery, centerz)) children();
}
module vapply(ms) {
	if((vlevel(ms) == 2)) multmatrix(ms) children();
	else for(m = ms) vapply(m) children();
}
module vtr(x = 0, y = 0, z = 0) {
	v = (vislist(x) ? x : [x, y, z]);
	translate(v) children();
}
module vtx(x) {
	translate([x, 0, 0]) children();
}
module vty(y) {
	translate([0, y, 0]) children();
}
module vtz(z) {
	translate([0, 0, z]) children();
}
module vrx(angle) {
	multmatrix(vrx(angle)) children();
}
module vry(angle) {
	multmatrix(vry(angle)) children();
}
module vrz(angle, center = undef) {
	center = vopt(center, V0);
	translate(center) rotate(angle) translate(-center) children();
}
module vscale(s = 1, x = undef, y = undef, z = undef) {
	multmatrix(vscale(s, x, y, z)) children();
}
module vrotate(to, from = VZ) {
	multmatrix(vrotate(to, from)) children();
}
module vfollow(v, p = V0, s = 1, t = 0) {
	multmatrix(vfollow(v, p, s, t)) children();
}
module vcenter(size, center, centerx, centery, centerz) {
	multmatrix(vcenter(size, center, centerx, centery, centerz)) children();
}
module vapply(ms) {
	if((vlevel(ms) == 2)) multmatrix(ms) children();
	else for(m = ms) vapply(m) children();
}
module vsquare(size, center, centerx, centery, x, y) {
	vsize = vpoint(size, x, y);
	vcenter(vsize, center, centerx, centery) square(vabs([vsize.x, vsize.y]));
}
module vsquare_rounded(size, r, center, centerx, centery) {
	vcenter(size, center, centerx, centery) hull() {
		vtr(r, r) circle(r);
		vtr(r, (size.y - r)) circle(r);
		vtr((size.x - r), r) circle(r);
		vtr((size.x - r), (size.y - r)) circle(r);
	}
}
module varc(r = 1, a = 90) {
	pts = varc(r, a);
	polygon(pts);
}
module vtr(x = 0, y = 0, z = 0) {
	v = (vislist(x) ? x : [x, y, z]);
	translate(v) children();
}
module vtx(x) {
	translate([x, 0, 0]) children();
}
module vty(y) {
	translate([0, y, 0]) children();
}
module vtz(z) {
	translate([0, 0, z]) children();
}
module vrx(angle) {
	multmatrix(vrx(angle)) children();
}
module vry(angle) {
	multmatrix(vry(angle)) children();
}
module vrz(angle, center = undef) {
	center = vopt(center, V0);
	translate(center) rotate(angle) translate(-center) children();
}
module vscale(s = 1, x = undef, y = undef, z = undef) {
	multmatrix(vscale(s, x, y, z)) children();
}
module vrotate(to, from = VZ) {
	multmatrix(vrotate(to, from)) children();
}
module vfollow(v, p = V0, s = 1, t = 0) {
	multmatrix(vfollow(v, p, s, t)) children();
}
module vcenter(size, center, centerx, centery, centerz) {
	multmatrix(vcenter(size, center, centerx, centery, centerz)) children();
}
module vapply(ms) {
	if((vlevel(ms) == 2)) multmatrix(ms) children();
	else for(m = ms) vapply(m) children();
}
module vcube(size, center, centerx, centery, centerz, x, y, z) {
	vsize = vpoint(size, x, y, z);
	vcenter(vsize, center, centerx, centery, centerz) cube(vabs(vsize));
}
module vcyl(height = 10, radius = 5, r1, r2, center = false) {
	r1 = vopt(r1, radius);
	r2 = vopt(r2, radius);
	cylinder(h = height, r1 = r1, r2 = r2, center = center);
}
module vtube(height = 10, radius = 5, thickness = 2, r1, r2, center = false) {
	r1 = vopt(r1, radius);
	r2 = vopt(r2, radius);
	difference() {
		cylinder(h = height, r1 = r1, r2 = r2, center = center);
		vtz(-VEPSILON) cylinder(h = (height + (2 * VEPSILON)), r1 = (r1 - thickness), r2 = (r2 - thickness), center = center);
	}
}
module vspherical_cap(radius = 10, height = 4) {
	sphere_radius = ((vsq(radius) + vsq(height)) / (2 * height));
	vtz((-sphere_radius + height)) difference() {
		sphere(sphere_radius);
		vtz(-height) cube((2 * sphere_radius), true);
	}
}
module vtore_cap(outer = 20, inner = 2) {
	cut_size = ((outer + VEPSILON) * 2);
	intersection() {
		vcube([cut_size, cut_size, (inner + VEPSILON)], centerx = true, centery = true);
		union() {
			rotate_extrude() vtx((outer - inner)) circle(r = inner);
			vcyl((inner * 2), (outer - inner), center = true);
		}
	}
}
module vtore(outer = 20, inner = 2) {
	rotate_extrude() vtx((outer - inner)) circle(r = inner);
}
module vbase_arrow(h, d = VARROW_D, cone_h = undef, cone_d = undef) {
	cd = vopt(cone_d, (d * 2));
	ch = min(h, vopt(cone_h, (d * 3)));
	ih = max(0, (h - ch));
	cylinder(ih, d = d);
	vtz(ih) cylinder(ch, d1 = cd, d2 = 0);
}
module varrow(h_v, d = VARROW_D, cone_h = undef, cone_d = undef) {
	if(visnum(h_v)) vbase_arrow(h_v, d, cone_h, cone_d);
	else {
		h = norm(h_v);
		vrotate(h_v) vbase_arrow(h, d, cone_h, cone_d);
	}
}
module vreinfor(size, e = 0, x, y, z, ex, ez) {
	s = vpoint(size, x, y, z);
	ex = vopt(ex, e);
	ez = vopt(ez, e);
	ns = (s + [ex, 0, ez]);
	vtz(-s.z) difference() {
		vtx(-ex) vcube(ns, centery = true);
		scale([1, 1, (s.z / s.x)]) vtx(s.x) vrx(90) cylinder(h = (s.y + (VEPSILON * 2)), r = s.x, $fn = 30, center = true);
	}
}
module vextrude_face(pts, h) {
	v = (visnum(h) ? [0, 0, h] : h);
	bottom = ((len(pts[0]) == 3) ? pts : v2dto3d(pts));
	top = [for(p = bottom) ((p + v))];
	vpoly_2faces(bottom, top);
}
module vpoly_2faces(bottom, top) {
	vpoly_faces([bottom, top]);
}
module vpoly_faces(fcs) {
	m = len(fcs);
	bottom = fcs[0];
	n = len(bottom);
	is = vindexes(bottom);
	points = concat([for(face = fcs) (each (face))]);
	faces = [[for(i = is) (i)], [for(i = is) ((((m * n) - i) - 1))], for(j = vrange((m - 1), inc = n)) (for(i = is) ([((i + n) + j), ((((i + 1) % n) + n) + j), (((i + 1) % n) + j), (i + j)]))];
	polyhedron(points = points, faces = faces, convexity = 2);
}
module vprism(size, center, centerx, centery, centerz, x, y, z) {
	v = (vislist(size[0]) ? vpoint(size[0], x, y, z) : vpoint(size, x, y, z));
	h = (vislist(size[1]) ? vpoint(size[1], x, y, z) : vpoint(size, x, y, z));
	pts = concat(vsquare(v, z = 0), [[0, (h.y / 2), h.z], [v.x, (h.y / 2), h.z]]);
	fcs = [[0, 1, 2, 3], [5, 4, 3, 2], [0, 4, 5, 1], [0, 3, 4], [5, 2, 1]];
	vcenter(v, center, centerx, centery, centerz) polyhedron(points = pts, faces = fcs);
}
module vhull2(ms, chamfer = true) {
	skip = (chamfer ? 1 : 2);
	for(i = [0 : skip : (len(ms) - 2)]) hull() {
		multmatrix(ms[i]) children();
		multmatrix(ms[(i + 1)]) children();
	}
}
module vextrude_simple(path, s = 1, t = 0) {
	vhull2(vfollow_simple(path, s, t), true) children();
}
module vextrude_direct(path, s = 1, t = 0) {
	vhull2(vfollow_direct(path, s, t), true) children();
}
module vextrude_middle(path, s = 1, t = 0) {
	vhull2(vfollow_middle(path, s, t), true) children();
}
module vextrude_dup(path, s = 1, t = 0, chamfer = true) {
	vhull2(vfollow_dup(path, s, t), chamfer) children();
}
module vextrude_bezier3(path, s = 1, t = 0) {
	vextrude_direct(vbezier3(path), s, t, $fn = 0) children();
}
module vextrude_bezier4(path, s = 1, t = 0, c = 0.5) {
	ps = ((c == 0) ? path : vcontrol(path, c));
	vextrude_direct(vbezier4(ps), s, t, $fn = 0) children();
}
module vextrude_rot(a = 360, r, s = 1, d, n = VY, h = 0) {
	vhull2(vfollow_rot(a, r, s, d, n, h), true) children();
}
module vextrude_helix(h = 5, p = 1, r, s = 1, d, a, n = VZ) {
	vhull2(vhelix(h, p, r, s, d, a, n), true) children();
}
module passage() {
	module plat() {
		vcube([d_roue.x, (d + VEPSILON), (d_roue.z - a)], centery = true);
		vtx(a) vcube([(d_roue.x - a), d, d_roue.z], centery = true);
		vtz((d_roue.z - a)) vtx(a) vrx(-90) vcyl(d, a, center = true);
	}
	module arrondi() {
		intersection() {
			vcube([d_roue.x, d_roue.z, d_roue.z]);
			vry(90) vtz(a) {
				vrx(180) vtore_cap(d_roue.z, a);
				vtz(-VEPSILON) vcyl(((d_roue.x - a) + VEPSILON), d_roue.z);
			}
		}
	}
	module arrondis() {
		vty((d / 2)) arrondi();
		vty((-d / 2)) mirror(VY) arrondi();
	}
	a = r_passage;
	d = (d_roue.y - (d_roue.z * 2));
	plat();
	arrondis();
}
module passage_droit() {
	vtr(p_passage) passage();
}
module passage_gauche() {
	mirror(VX) vtr(p_passage) passage();
}
module passages() {
	passage_droit();
	passage_gauche();
}
module bloc() {
	module plein() {
		intersection() {
			vcube(d_bloc);
			union() {
				h = (d_bloc.z - d_roue.z);
				h_plateau = 4.5;
				vty(2.2) vtz(12) vrx(15) vcube(d_bloc);
				vcube([d_bloc.x, d_bloc.y, (d_roue.z - 1)]);
				vtz((d_bloc.z - h_plateau)) vcube([d_bloc.x, d_bloc.y, h_plateau]);
			}
		}
	}
	module creux() {
		a = r_passage;
		d = (d_roue.y - (d_roue.z * 2));
		delta = 1;
		vtr(-delta, ((-d / 2) - delta), delta) vry(90) vty(p_passage.y) vtz(a) {
			vrx(180) vtore_cap(d_roue.z, a);
			vtz(-VEPSILON) vcyl(((d_roue.x - a) + (delta * 2)), d_roue.z);
		}
	}
	vtr(p_bloc) difference() {
		plein();
		creux();
	}
}
module marche() {
	module creux() {
		r1 = 9;
		r2 = 20;
		e = 3;
		bord = [[0, m.z], [0, 0], [m.y, 0], [m.y, m.z]];
		rs_bord = [0, r1, [r2, m.z], 0];
		ext = [[(m.y + e), m.z], [(m.y + e), -e], [-e, -e], [-e, m.z]];
		rs_ext = [0, 0, 0, 0];
		rs = concat(rs_bord, rs_ext);
		forme = concat(bord, ext);
		vrz(90) vrx(90) linear_extrude(m.x) polygon(vround_path(forme, rs));
		vcube([-e, m.y, m.z]);
	}
	module rebord() {
		l1 = 30;
		h1 = 9;
		r1 = 5;
		l2 = 12.5;
		h2 = 5.5;
		r2 = 5.5;
		bord = [[m.x, (m.y + 10)], [m.x, m.y], [0, m.y], [0, 0], [m.x, 0], [m.x, -l1]];
		ext = [[(m.x - h1), -l1], [(m.x - h1), -h2], [-h2, -h2], [-h2, ((m.y + r2) + l2)]];
		forme = concat(bord, ext);
		rs_bord = [for(i = vindexes(bord)) (0)];
		rs_ext = [r1, r1, r2, r2];
		rs = concat(rs_bord, rs_ext);
		linear_extrude(1) polygon(vround_path(forme, rs));
	}
	m = d_marche;
	vtr(p_marche) {
		creux();
		vtz(m.z) rebord();
	}
}
module sol() {
	module creux_marche() {
		m = d_marche;
		vtz((m.z - 1)) vtr(p_marche) vcube([(m.x + 1), m.y, 3], centerz = true);
	}
	difference() {
		vcube(d_sol, centerx = true);
		creux_marche();
	}
}
module aeration() {
	module base(e = 0) {
		r = r_aeration;
		l1 = (d_aeration.x + (e * 2));
		l2 = (l1 - 6);
		h = (d_aeration.y + e);
		forme = [[(-l2 / 2), 0], [(l2 / 2), 0], [(l1 / 2), (h - e)], [(-l1 / 2), (h - e)]];
		rs = [r, r, 1, 1];
		vty(-e) linear_extrude(VEPSILON) polygon(vround_path(forme, rs));
	}
	module rebord() {
		h = 0.5;
		hull() {
			base(h);
			vtz(h) base(h);
		}
	}
	module bloc() {
		hull() {
			base();
			vtz(4) vrx(2) base(-4);
		}
	}
	vtr(p_aeration) {
		rebord();
		bloc();
	}
}
module sol_haut() {
	function base() = let(forme = [[(-d.x / 2), 0], [(-d.x / 2), r1], [(d.x / 2), r1], [(d.x / 2), 0], [(d.x / 2), (d.y - r1)], [(-d.x / 2), (d.y - r1)]]) let(rs = [0, [r1, r2], [r2, r1], 0, 0, 0]) vround_path(forme, rs);
	module sol_haut_base() {
		function base() = let(forme = [[(-d.x / 2), 0], [(-d.x / 2), r1], [(d.x / 2), r1], [(d.x / 2), 0], [(d.x / 2), (d.y - r1)], [(-d.x / 2), (d.y - r1)]]) let(rs = [0, [r1, r2], [r2, r1], 0, 0, 0]) vround_path(forme, rs);
		h = [0, yr, d.z];
		vtr([p.x, (p.y - r1), p.z]) vextrude_face(base(), h);
	}
	d = d_sol_haut;
	p = p_sol_haut;
	yr = 10;
	r1 = 5;
	r2 = 20;
	sol_haut_base();
	vtr([p.x, (p.y - r1), p.z]) vty((yr + r1)) vcube([d.x, (d.y - yr), d.z], centerx = true);
}
module porte_arriere(gauche) {
	module coin_fenetre(bas = true) {
		function rebord_coin(o, a = 0) = let(ma = 50) let(i = ((a < ma) ? 0 : ((a - ma) / (90 - ma)))) let(o = ((a < ma) ? o : [o.x, (y1 + ((y2 - y1) * i)), o.z])) let(r1 = ((a < ma) ? r1 : (r1 + ((r2 - r1) * i)))) let(t = (1 - tan(a))) let(p1 = [(o.x - (sin(a) * r)), (o.z - (cos(a) * r))]) let(p2 = ((t > 0) ? [(o.x * t), 0] : [0, (o.z - (o.z / tan(a)))])) let(pts = [[p1.x, o.y, p1.y], [p2.x, o.y, p2.y], [p2.x, 0, p2.y], [p1.x, 0, p1.y]]) let(rs = [r1, 0, 0, 0]) vround_path(pts, rs, $fn = 4);
		y2 = 7;
		y1 = (bas ? d.y : y2);
		r = 10;
		r2 = 2;
		r1 = (bas ? 5 : r2);
		o = [((3 + r) + r2), y1, ((4 + r) + r1)];
		faces = [rebord_coin([(df.x / 2), o.y, o.z]), for(a = [0 : 15 : 90]) (rebord_coin(o, a)), rebord_coin([o.x, o.y, (df.z / 1.5)], 90)];
		vtr(pf) vpoly_faces(faces);
	}
	module coins_fenetre() {
		coin_fenetre(true);
		vtz(((p.z + d.z) + df.z)) mirror(VZ) coin_fenetre(false);
		vtx(df.x) mirror(VX) {
			coin_fenetre(true);
			vtz(((p.z + d.z) + df.z)) mirror(VZ) coin_fenetre(false);
		}
	}
	module protection() {
		dp = [(d.x - 8), 1, (pf.z - 4)];
		pp = [4, d.y, 3];
		r = 5;
		vtr(pp) {
			pts = [[0, 0, 0], [dp.x, 0, 0], [dp.x, 0, dp.z], [0, 0, dp.z]];
			rs = vvect(4, r);
			face = vround_path(pts, rs);
			vextrude_face(face, [0, dp.y, 0]);
		}
	}
	d = (gauche ? d_porteg : d_ported);
	p = (gauche ? p_porteg : p_ported);
	df = [d.x, d.y, 59];
	pf = [0, 0, 60];
	vtr(p) {
		color("White") {
			vcube([d.x, d.y, pf.z], centerx = false);
			coins_fenetre();
		}
		color("Gray") protection();
	}
}
module portes_arrieres() {
	porte_arriere(true);
	mirror(VX) porte_arriere(false);
}
module fenetre_arriere() {
	module rebord_fenetre() {
		x1 = ds.x;
		r = 10;
		r1 = 5;
		o = [x1, (r + r1), (r + r1)];
		dcoin = (25 - r);
		faces = [rebord_coin(o, r, r1, (90 - VEPSILON), [0, 0, dcoin]), for(a = [270 : 15 : 359]) (rebord_coin(o, r, r1, a, [0, 0, ds.z])), for(a = [180 : 15 : 269]) (rebord_coin(o, r, r1, a, [0, ds.y, ds.z])), for(a = [90 : 15 : 179]) (rebord_coin(o, r, r1, a, [0, ds.y, 0])), for(a = [0 : 15 : 45]) (rebord_coin(o, r, r1, a, [0, dcoin, 0])), for(a = [45 : 15 : 89]) (rebord_coin(o, r, r1, a, [0, 0, dcoin])), rebord_coin(o, r, r1, (90 - VEPSILON), [0, 0, dcoin])];
		vtr(ps) vpoly_faces(faces);
	}
	module creux() {
		pts = [[0, 0, 0], [0, ds.y, 0], [0, ds.y, ds.z], [0, 0, ds.z]];
		face = vround_cut_path(pts, [15, 0, 0, 0]);
		vtx(-VEPSILON) vtr(ps) vextrude_face(face, ((d.x + (2 * VEPSILON)) * VX));
	}
	module protection() {
		dp = [2, d.y, 67];
		pp = [d.x, 0, d_marche.z];
		vtr(pp) vcube(dp);
	}
	d = dfenetre_arriere;
	p = pfenetre_arriere;
	ds = [d.x, 88, 52];
	ps = [0, 7, (74 + d_marche.z)];
	vtr(p) {
		vwhite() {
			difference() {
				vcube(d);
				creux();
			}
			rebord_fenetre();
		}
		color("Gray") protection();
	}
}
module fenetres_arrieres() {
	fenetre_arriere();
	mirror(VX) fenetre_arriere();
}
module fenetre_avant() {
	module rebord_fenetre() {
		x1 = ds.x;
		r = 10;
		r1 = 5;
		o = [x1, (r + r1), (r + r1)];
		dcoin = (25 - r);
		faces = [rebord_coin(o, r, r1, (90 - VEPSILON), [0, 0, dcoin]), for(a = [270 : 15 : 359]) (rebord_coin(o, r, r1, a, [0, 0, ds.z])), for(a = [180 : 15 : 269]) (rebord_coin(o, r, r1, a, [0, ds.y, ds.z])), for(a = [90 : 15 : 134]) (rebord_coin(o, r, r1, a, [0, ds.y, dcoin])), for(a = [135 : 15 : 179]) (rebord_coin(o, r, r1, a, [0, (ds.y - dcoin), 0])), for(a = [0 : 15 : 45]) (rebord_coin(o, r, r1, a, [0, dcoin, 0])), for(a = [45 : 15 : 89]) (rebord_coin(o, r, r1, a, [0, 0, dcoin])), rebord_coin(o, r, r1, (90 - VEPSILON), [0, 0, dcoin])];
		vtr(ps) vpoly_faces(faces);
	}
	module creux() {
		pts = [[0, 0, 0], [0, ds.y, 0], [0, ds.y, ds.z], [0, 0, ds.z]];
		face = vround_cut_path(pts, [15, 25, 0, 0]);
		vtx(-VEPSILON) vtr(ps) vextrude_face(face, ((d.x + (2 * VEPSILON)) * VX));
	}
	module protection() {
		dp = [2, d.y, 67];
		pp = [d.x, 0, d_marche.z];
		vtr(pp) vcube(dp);
	}
	d = dfenetre_avant;
	p = pfenetre_avant;
	ds = [d.x, 107, 52];
	ps = [0, 7, (74 + d_marche.z)];
	vtr(p) {
		vwhite() {
			difference() {
				vcube(d);
				creux();
			}
			rebord_fenetre();
		}
		color("Gray") protection();
	}
}
module porte_lateralle() {
	d = dfenetre_avant;
	v = (lateral_ouvert ? [(d.x + 1), (-d.y + 10), 0] : V0);
	vtr(v) mirror(VX) fenetre_avant();
}
module fenetres_avants() {
	fenetre_avant();
	porte_lateralle();
}
module milieu() {
	function face(z = 0) = let(d = ((z <= db.z) ? db : dh)) let(pts = [[0, (-d.y / 2), z], [0, (d.y / 2), z], [d.x, (d.y / 2), z], [d.x, (-d.y / 2), z]]) vround_path(pts, [0, 0, 2, 2], $fn = 6);
	db = dmilieu_bas;
	dh = dmilieu_haut;
	p = pmilieu;
	vtr(p) {
		faces = [face(db.z), face((db.z + 15)), face((db.z + dh.z))];
		vgray() vextrude_face(face(), (db.z * VZ));
		vwhite() vpoly_faces(faces);
	}
}
module milieux() {
	milieu();
	mirror(VX) milieu();
}
module coin() {
	d = d_coin;
	p = p_coin;
	pts = [[0, 0, 0], [0, d.y, 0], [d.x, d.y, 0], [d.x, 0, 0]];
	face = vround_path(pts, [0, 0, 5, 0], $fn = 4);
	vtr(p) vwhite() vextrude_face(face, (d.z * VZ));
}
module coins() {
	coin();
	mirror(VX) coin();
}
module vextrudex(d, rs) {
	face = faceyz(d, rs);
	vextrude_face(face, (d.x * VX));
}
module siege() {
	module assise() {
		vextrudex(d_assise, [[15, 45], 5, 10, 0]);
	}
	module dossier() {
		d = d_dossier;
		pts = [[0, 0, 0], [0, d.y, 0], [0, (d.y - 7), d.z], [0, 0, d.z]];
		face = vround_path(pts, [0, 5, 4, 5]);
		vextrude_face(face, (d.x * VX));
	}
	module appui() {
		d = d_appui_tete;
		pts = [[0, 0, 0], [0, d.y, 0], [0, (d.y - 8), d.z], [0, 0, d.z]];
		face = vround_path(pts, [3, 8, 2, 2]);
		vextrude_face(face, (d.x * VX));
	}
	module accoudoir() {
		d = d_accoudoir;
		pts = [[0, 0, 0], [0, d.y, 0], [0, d.y, (d.z - 5)], [0, 0, d.z]];
		face = vround_path(pts, [5, 2, 2, 5]);
		vextrude_face(face, (d.x * VX));
	}
	d_assise = [50, 60, 20];
	p_assise = [0, 0, 19];
	d_dossier = [50, 17, 53];
	p_dossier = [0, 0, (p_assise.z + d_assise.z)];
	d_appui_tete = [30, 12, 21];
	p_appui_tete = [((d_siege.x - d_appui_tete.x) / 2), 0, ((p_dossier.z + d_dossier.z) + 2)];
	d_accoudoir = [5, 40, 10];
	p_accoudoir = [-d_accoudoir.x, 3, (p_dossier.z + (d_dossier.z / 2.5))];
	vtr(p_siege) {
		vtr(p_assise) assise();
		vtr(p_dossier) dossier();
		vtr(p_appui_tete) appui();
		vtr(p_accoudoir) accoudoir();
	}
}
module sieges() {
	color("DimGrey") {
		siege();
		mirror(VX) siege();
	}
}
module trafic() {
	color("White") passages();
	color("Gray") {
		bloc();
		sol();
		sol_haut();
	}
	color("DimGray") {
		marche();
		aeration();
	}
	portes_arrieres();
	fenetres_arrieres();
	fenetres_avants();
	milieux();
	coins();
	sieges();
}
VVERSION = [2015, 11, 26];
VVERSION_YEAR = VVERSION[0];
VVERSION_MONTH = VVERSION[1];
VVERSION_DAY = VVERSION[2];
VVERSION_NUM = (VVERSION * [(100 * 100), 100, 1]);
VEPSILON = 0.01;
VPI = 3.14159;
VX = [1, 0, 0];
VY = [0, 1, 0];
VZ = [0, 0, 1];
V0 = [0, 0, 0];
V1 = [1, 1, 1];
VNULL_VECTORS = [[], [0], [0, 0], [0, 0, 0], [0, 0, 0, 0]];
VUNITARY_VECTORS = [[], [1], [1, 1], [1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1, 1]];
VARROW_D = 0.3;
//Description("taille plancher")
//Parameter("")
d_sol = [161, 300, -1];
//Description("taille et position passage de roues")
//Parameter("")
d_roue = [18, 77, 29];
p_passage = [((d_sol.x / 2) - d_roue.x), 78.5];
//Parameter("")
r_passage = 5;
//Description("bloc plastique arrière")
//Parameter("")
d_bloc = [19, 60, 63];
p_bloc = [((d_sol.x / 2) - d_bloc.x), 0];
//Description("marche-pied")
//Parameter("")
d_marche = [20, 68, 10];
p_marche = [((d_sol.x / 2) - d_marche.x), 160, -d_marche.z];
//Description("aeration au sol")
//Parameter("")
d_aeration = [45, 27, 5];
//Parameter("")
p_aeration = [0, 219, 0];
//Parameter("courbure de la forme")
r_aeration = 4;
d_sol_haut = [161, (d_sol.y - 246), 11];
//Parameter("")
p_sol_haut = [0, 246, 0];
//Description("portes arrières")
//Parameter("")
d_porteg = [73, 11, 129];
p_porteg = [-3, -d_porteg.y, 0];
//Parameter("")
d_ported = [66, 11, 129];
p_ported = [3, -d_porteg.y, 0];
dfenetre_arriere = [8, 100, (127 + d_marche.z)];
pfenetre_arriere = [((-d_sol.x / 2) - dfenetre_arriere.x), 12, -d_marche.z];
dfenetre_avant = [8, 118, (127 + d_marche.z)];
pfenetre_avant = [((-d_sol.x / 2) - dfenetre_avant.x), (pfenetre_arriere.y + dfenetre_arriere.y), -d_marche.z];
//Description("sièges")
//Parameter("")
d_siege = [50, 60, 114];
p_siege = [15, (p_sol_haut.y + 20), d_sol_haut.z];
//Description("renflement milieu")
//Parameter("")
dmilieu_bas = [4, 27, 67];
dmilieu_haut = [3, 10, (127 - dmilieu_bas.z)];
pmilieu = [(-d_sol.x / 2), (pfenetre_arriere.y + dfenetre_arriere.y), 0];
//Description("coins arrières")
//Parameter("")
d_coin = [14, 12, 127];
p_coin = [(-d_sol.x / 2), 0, 0];
//Parameter("")
lateral_ouvert = false;
trafic();
