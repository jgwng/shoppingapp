String validateName(String value){
  if(value != ""){
    return null;
  }else{
    return '이름을 입력해주세요';
  }
}

String validatePhoneNumber(String value){
  if(value.length != 11){
    return '전화번호를 확인해주세요';
  }
  return null;
}

String validateSecondAddress(String value){
  if(value != ""){
    return null;
  }else{
    return '주소를 입력해주세요';
  }
}

String validateTitle(String value){
  if(value != ""){
    return null;
  }else{
    return '제목을 입력해주세요';
  }
}
