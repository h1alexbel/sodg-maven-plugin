/*
 * SPDX-FileCopyrightText: Copyright (c) 2016-2025 Objectionary.com
 * SPDX-License-Identifier: MIT
 */
package org.eolang.sodg;

import java.io.File;
import java.nio.file.Path;

/**
 * Make the place for the object.
 *
 * @since 0.1
 */
final class Place {
    /**
     * Name of the object.
     */
    private final String name;

    /**
     * Ctor.
     * @param obj The name of the object
     */
    Place(final String obj) {
        this.name = obj;
    }

    /**
     * Make a full path.
     * @param dir The dir
     * @param ext The ext
     * @return Full path
     */
    Path make(final Path dir, final String ext) {
        final StringBuilder out = new StringBuilder();
        out.append(this.name.replace(".", File.separator));
        if (!ext.isEmpty()) {
            out.append('.').append(ext);
        }
        return dir.resolve(out.toString());
    }
}
