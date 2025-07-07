
  enum NetworkErrors {
    invalidCredentials('Usuario o contraseña incorrectos'),
    serviceUnavailable('Servicio no disponible'),
    serverError('Error del servidor, intenta más tarde'),
    noConnection('Error de conexión a internet');

    const NetworkErrors(this.message);
    final String message;

    static NetworkErrors fromHttpCode(int code) {
       switch (code) {
        case 401:
        case 403:
          return NetworkErrors.invalidCredentials;
        case 404:
          return NetworkErrors.serviceUnavailable;
        case 500:
        case 502:
        case 503:
          return NetworkErrors.serverError;
        default:
          return NetworkErrors.noConnection;
      }
    }
  }