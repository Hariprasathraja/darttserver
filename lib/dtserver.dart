import 'package:grpc/grpc.dart';
import 'generated/counter.pbgrpc.dart';

class Dtserver extends CounterServiceBase{
  int counter=1;

  @override
  Future<CounterResponse> incrementCounter(ServiceCall call, Empty request)async{
    counter++;
    return CounterResponse()..counter=counter;
  }

  @override
  Future<CounterResponse> getCounter(ServiceCall call, Empty request)async{
    return CounterResponse()..counter=counter;
  }
}

Future<void> main() async{
  final server= Server(
  [Dtserver()],
  const<Interceptor>[],
  CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  );

  await server.serve(port: 50051);
  print('Server listening on port: ${server.port}..');
}

