import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../data/repositories/account_repository.dart';
import 'service_locator.dart';

part 'app_providers.g.dart';

@Riverpod(keepAlive: true)
Client client(Ref ref) => getIt<Client>();

@Riverpod(keepAlive: true)
AccountRepository accountRepository(Ref ref) => getIt<AccountRepository>();
