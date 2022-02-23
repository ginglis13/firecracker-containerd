#! /bin/bash
#
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may
# not use this file except in compliance with the License. A copy of the
# License is located at
#
# 	http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is distributed
# on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
# express or implied. See the License for the specific language governing
# permissions and limitations under the License.


CRITEST_BUILD_NUMBER="$CRITEST_BUILD_NUMBER"

set -euo pipefail

# Remove up until report summary
sed -i '0,/^Summarizing [0-9][0-9] Failures:$/d' /tmp/"$CRITEST_BUILD_NUMBER".out # Remove empty lines
sed -i '/^$/d' /tmp/"$CRITEST_BUILD_NUMBER".out

# Remove unnecessary error messages
sed -i '/^\/.*[0-9]$/d' /tmp/"$CRITEST_BUILD_NUMBER".out
sed -i '/^Ran [0-9][0-9] of [0-9][0-9] Specs in .*seconds$/d' /tmp/"$CRITEST_BUILD_NUMBER".out
sed -i '/^--- FAIL: TestCRISuite.*$/d' /tmp/"$CRITEST_BUILD_NUMBER".out

# Diff expected vs. actual
diff -y <(sort critest/expected_critest_output.out) <(sort /tmp/"$CRITEST_BUILD_NUMBER".out)