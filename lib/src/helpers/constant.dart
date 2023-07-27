const String garageApi = 'https://garage-oapi-net6.garage.out.nakamenosakura.com/';
const String garageProposalOApi = 'https://garage-proposaloapi.garage.out.nakamenosakura.com/';

// 2-3 Get Image
getImageUrl(fileId){
  return '${garageApi}v1.0/file/thumbnail/$fileId';
}