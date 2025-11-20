import 'package:buddy_app/features/example/application/api_call_1_repo.dart';
import 'package:buddy_app/utils/api_state_folder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/widgets/screen_outline.dart';

class ApiCall1Screen extends ConsumerStatefulWidget {
  const ApiCall1Screen({super.key});

  @override
  ConsumerState<ApiCall1Screen> createState() => _ApiCall1ScreenState();
}

class _ApiCall1ScreenState extends ConsumerState<ApiCall1Screen> {
  @override
  Widget build(BuildContext context) {
    // Obtain the repository provider which holds API state.
    final repo = ref.watch(apiCall1RepoProvider);

    return ScreenOutline(
      body: ApiStateFolder(
        // List of repositories whose state is monitored.
        repos: [repo],
        // onRefresh callback triggers a new API call execution.
        onRefresh: () async {
          await repo.execute();
        },
        // Loading widget to show a circular progress indicator while fetching data.
        buildLoading: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
        // Display data when API call is successful.
        buildLoaded: (BuildContext context) {
          // Access the latest successful API result.
          final model = repo.latestValidResult;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: model != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display model properties.
                      Text('Name: ${model.name}'),
                      const SizedBox(height: 8),
                      Text('Email: ${model.email}'),
                    ],
                  )
                : const Center(child: Text('No data available')),
          );
        },
        // The ApiStateFolder internally determines error state and shows an error widget.
      ),
    );
  }
}
