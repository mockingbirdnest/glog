#include "stacktrace.h"

#include "base/debug/stack_trace.h"

_START_GOOGLE_NAMESPACE_

// If you change this function, also change GetStackFrames below.
int GetStackTrace(void** result, int max_depth, int skip_count) {
  ::base::debug::StackTrace stacktrace(skip_count);

  size_t size;
  const void* const* addresses = stacktrace.Addresses(&size);

  if (size > max_depth)
    size = max_depth;
  for (size_t i = 0; i < size; i++)
    result[i] = const_cast<void*>(addresses[i]);

  return size;
}

_END_GOOGLE_NAMESPACE_
