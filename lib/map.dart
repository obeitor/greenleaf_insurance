Map service = {
  'local':{
    'url':'localhost:5000',
    'ssl':false
  },
  'dev':{
    'url':'greenleaf-service-0-0-2.onrender.com',
    'ssl':true
  }
};

String env = 'dev';
String baseUrl = service[env]['url'];
bool baseUrlSSL = service[env]['ssl'];