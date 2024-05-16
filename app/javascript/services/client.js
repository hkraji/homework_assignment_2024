import axios from 'axios';

const apiClient = axios.create({
  headers: {
    'Content-Type': 'application/json',
  }
});

apiClient.interceptors.request.use(async (config) => {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  config.headers['X-CSRF-Token'] = csrfToken;
  return config;
}, (error) => Promise.reject(error));

export default apiClient;
