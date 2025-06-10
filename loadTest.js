import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
  vus: 50,         // virtual users
  duration: '10s', // test duration
};

export default function () {
  let res = http.get('http://127.0.0.1:8000/');
  check(res, {
    'status was 200': (r) => r.status === 200,
  });
  sleep(1); // simulate user think time
}
