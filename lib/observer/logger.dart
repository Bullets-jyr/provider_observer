import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  // Provider가 초기화될 때 호출됩니다.
  // 주목해야할 부분은 정의되는 시점이 아닌 초기화될 때 호출된다는 점입니다.
  // 한 Provider가 초기화되는 시점은 다른 Provider 또는 위젯이 그 Provider를 watch하거나 listen하거나
  // read할 때 입니다.
  @override
  void didAddProvider(
      ProviderBase<Object?> provider,
      // Provider가 expose하는 value
      Object? value,
      // Provider들의 state를 담고 있는 ProviderContainer
      // flutter앱에서는 Provider Scope가 내부적으로 ProviderContainer를 만들어줍니다.
      ProviderContainer container,
      ) {
    // provider.name property는 현재 수동으로 Provider를 만들 때, 사용할 수 있습니다.
    // riverpod generator를 사용할 때, provider.name property를 사용할 수 있게 해주는 기능은
    // 현재 remi가 개발중에 있습니다.

    // multi-line print
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType} is initialized",
  "value exposed": "$value"
}
''');
    super.didAddProvider(provider, value, container);
  }

  // Provider가 dispose될 때 호출됩니다.
  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider,
      ProviderContainer container,
      ) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType} disposed"
}
''');
    super.didDisposeProvider(provider, container);
  }

  // state 변화를 tracking하는데 유용하게 사용할 수 있습니다.
  // 만약 value가 primitive 타입이 아니고, object 타입이라면 toString 메서드를 override하는 걸 추천합니다.
  // 그렇지 않으면 instance of object name과 같이 value가 출력이되는데 이 경우 별로 많은 정보를 제공해주지 않기 때문입니다.
  @override
  void didUpdateProvider(
      ProviderBase<Object?> provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType} updated",
  "previous value": "$previousValue",
  "new value": "$newValue"
}
''');
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}